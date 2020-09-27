module ChatbotHelper
    include ApplicationHelper
    include LocationHelper
    include CalltypeHelper

    def last_message(call_id)
        last_msg = ""
        raw = Store.find_by_call_id(call_id.to_s).item
        messages = JSON.parse(raw)["messages"]
        messages.each do |item|
            if !item["message"].nil?
                if item["message"]["origin"].to_s == "local" && !item["message"]["texts"].nil?
                    last_msg = item["message"]["texts"].last
                end
            end
        end unless messages.nil?
        return last_msg
    end

    def get_identifier(msg_text, lang)
        cbr = BotResponse.where(lang: lang).where("seq < ?", 1000).sort_by { |item| item['seq'].to_i }.to_a # Chat Bot Responses
        cbr.each do |item|
            if msg_text.gsub("?","").match?("^" + msg_placeholder_wildcard(item["message"]).gsub("?","") + "$")
                return item["identifier"]
            end
        end
        return ""
    end

    def my_clean(text)
        text.gsub("?","").gsub("<","").gsub(">","").gsub("/","").gsub(":","").gsub("'","").gsub("(","").gsub(")","").gsub("+","")
    end

    def active_responses(msg_text, lang)
        cbr = BotResponse.where(lang: lang).where("seq < ?", 1000).sort_by { |item| item['seq'].to_i }.to_a # Chat Bot Responses
        ar = [] # Active Responses
        active = false
        cbr.each do |item|
            if active
                ar << item
            else
                if my_clean(msg_text).match?("^" + my_clean(msg_placeholder_wildcard(item["message"])) + "$")
                    if item["identifier"] == "menu" || item["identifier"] == "fallback"
                        ar = []
                        cbr.each do |item1|
                            if item1["seq"]>10
                                ar << item1
                            end
                        end
                        return ar
                    else
                        active = true
                    end
                end
            end
        end
        return ar
    end

    # boolean TRUE if question can be confirmed; otherwise FALSE
    def check_true(msg, lang)
        # use entries in BotResponse with seq=10xx to identify call type
        m = BotResponse.where(lang: lang).where("seq >= ?", 1100).where("seq < ?", 1200).to_a # Mappings
        result = "" # 
        m.each do |item|
            item["message"].split(",").each do |word|
                if msg.strip.downcase.include?(word.strip.downcase)
                    result = item["identifier"].to_s
                    break
                end
            end
            if result != ""
                break
            end
        end
        if result == "true"
            return true
        else
            return false
        end
    end

    # boolean TRUE if response is email or affirmative; otherwise FALSE
    def check_contact(msg, lang)
        if check_true(msg, lang)
            return true
        else
            return msg.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
        end
    end

    # boolean TRUE if response is in input options
    def check_response(msg, options)
        options.split(",").each do |opt|
            if msg.include?(opt)
                return true
            end
        end
        return false
    end

    def get_emailaddress(call_id)
        # TODO try to get email address from call information
        return ""
    end

    def msg_placeholder_completion(msg, call_id, lang, ct = "")
        if ct == ""
            ct = get_calltype(call_id, lang)
        end
        ct = translate_calltype(ct, lang)
        if ct == ""
            msg = msg.to_s.gsub("%%CALL_TYPE%%", "")
            msg = msg.to_s.gsub("%%CALL_TYPE_SHORT%%", "")
        else
            msg = msg.to_s.gsub("%%CALL_TYPE%%", " - " + ct)
            msg = msg.to_s.gsub("%%CALL_TYPE_SHORT%%", ct)
        end
        email = get_emailaddress(call_id)
        if email == ""
            msg = msg.to_s.gsub("%%EMAIL_ADDRESS%%", "")
        else
            msg = msg.to_s.gsub("%%EMAIL_ADDRESS%%", " (" + email + ")")
        end
        return msg
    end

    def dec112_welcome(call_id, lang)
      msg = ""
      item = BotResponse.where(identifier: "welcome", lang: lang)
      if item.count > 0
        msg = item.first.message
      end
      return msg_placeholder_completion(msg, call_id, lang)
    end

    def dec112_reply(msg, call_id, lang)
        stop_conversation = false
        # identify last message through call_id and get all conversation records with order that is lager then last message
        last_msg = last_message(call_id)

        # iterate over all records until condition is true or empty
        response_item = nil
        ars = active_responses(last_msg, lang).sort_by { |item| item['seq'].to_i }
        ars.each do |item|
            response_item = item
            if item["condition"].to_s[0..5] == "input:"
                if check_response(msg, item["condition"].to_s[6..1000])
                    break
                end
            else
                case item["condition"]
                when "skip"
                    # do nothing

                when ""
                    # empty condition is TRUE
                    break

                when "address_invalid"
                    # if msg does not contain city from reverse lookup => break
                    gps_location = get_gps_location(call_id)
                    if !msg.downcase.include?(gps_location[:city].to_s.downcase)
                        break
                    end

                when "calltype_missing"
                    ct = get_calltype(call_id, lang)
                    if ct == ""
                        break
                    end

                when "calltype_unclear"
                    ct = identify_calltype(msg, call_id, lang)
                    if ct == "" then 
                        break
                    else
                        set_calltype(call_id, ct)
                    end

                when "health_response"
                    ct = identify_calltype(msg, call_id, lang)
                    if ct == "health"
                        break
                    end

                when "awake_response"
                    if get_identifier(last_msg, lang) == "health_service"
                        response = !check_true(msg, lang)
                        if response
                            break
                        end
                    end

                when "fire_response"
                    ct = identify_calltype(msg, call_id, lang)
                    if ct == "fire"
                        break
                    end

                when "police_response"
                    ct = identify_calltype(msg, call_id, lang)
                    if ct == "police"
                        break
                    end

                when "data_confirmed"
                    response = check_true(msg, lang)
                    if response
                        break
                    end

                when "data_not_confirmed"
                    if get_identifier(last_msg, lang) == "chat_end"
                        response = !check_true(msg, lang)
                        if response
                            break
                        end
                    end

                when "contact_confirmed"
                    response = check_contact(msg, lang)
                    if response
                        stop_conversation = true
                        break
                    else
                        response_item = nil # must be set for last entry
                    end

                when "invalid_input"
                    case msg
                    when "1", "2", "3", "4", "9", "0"
                    else
                        break
                    end

                when "invalid_confirm"
                    break
                end
            end
puts "no match for " + msg.to_s
        end

        if response_item.nil?
            return "//dec112_exit"
        end
        return_msg = msg_placeholder_completion(response_item["message"], call_id, lang)
        if stop_conversation
            return_msg += "//dec112_exit"
        end
        return return_msg
    end
end

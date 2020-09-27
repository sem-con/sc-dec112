module CalltypeHelper

    def msg_placeholder_wildcard(msg)
        msg = msg.gsub("%%CALL_TYPE%%", ".*")
        msg = msg.gsub("%%CALL_TYPE_SHORT%%", ".*")
        msg = msg.gsub("%%EMAIL_ADDRESS%%", ".*")
        return msg
    end

    # return string police|fire|health based on information from chat protocol
    # return empty string "" if call type is not available so far
    def get_calltype(call_id, lang)
        record = Store.find_by_call_id(call_id.to_s)
        if record.nil?
            return ""
        end

        call_type = ""
        welcome_msg = BotResponse.where(identifier: "welcome", lang: lang).first.message rescue ""
        welcome_match = "^" + msg_placeholder_wildcard(welcome_msg).gsub("?","") + "$"
        calltype_msg = BotResponse.where(identifier: "call_type", lang: lang).first.message rescue ""
        calltype_match = "^" + msg_placeholder_wildcard(calltype_msg).gsub("?","") + "$"
        police_match = BotResponse.where(identifier: "police_service", lang: lang).first.message rescue ""
        health_match = BotResponse.where(identifier: "health_service", lang: lang).first.message rescue ""
        fire_match = BotResponse.where(identifier: "fire_service", lang: lang).first.message rescue ""
        cts = BotResponse.where(lang: lang).where("seq >= ?", 1000).where("seq < ?", 1010).to_a # Call Types

        JSON.parse(record.item)["messages"].each do |el|
            if el["message"].to_s != ""
                if el["message"]["origin"].to_s == "local" && el["message"]["texts"].to_s != ""
                    el["message"]["texts"].each do |item|
                        # check if it is welcome message including call-type
                        if item.to_s.gsub("?","").match?(welcome_match) ||
                           item.to_s.gsub("?","").match?(calltype_match) ||
                           item.to_s == police_match ||
                           item.to_s == health_match ||
                           item.to_s == fire_match
                            cts.each do |ct_item|
                                ct_item["message"].split(",").each do |word|
                                    if item.to_s.downcase.include?(word.downcase)
                                        call_type = ct_item["identifier"].to_s
                                        break
                                    end
                                end
                                if call_type != ""
                                    break
                                end
                            end
                        end
                        if call_type != ""
                            break
                        end

                        # check if Chatbot Response specifies call-type
                    end
                end
            end
            if call_type != ""
                break
            end
        end
        # TODO get call type from stored information

        return call_type
    end

    def set_calltype(call_id, call_type)
        # TODO write call type into record
    end

    def identify_calltype(msg, call_id, lang)
        call_type = get_calltype(call_id, lang)
        if call_type == ""
            # use entries in BotResponse with seq=10xx to identify call type
            cts = BotResponse.where(lang: lang).where("seq >= ?", 1000).where("seq < ?", 1010).to_a # Call Types
            cts.each do |item|
                item["message"].split(",").each do |word|
                    if msg.downcase.include?(word.downcase)
                        call_type = item["identifier"].to_s
                        break
                    end
                end
                if call_type != ""
                    break
                end
            end
        end
        return call_type # string police|fire|health based on msg input; empty if calltpye can't be identified
    end

    def map_uri_calltype(uri)
        call_type = ""
        cts = BotResponse.where("seq >= ?", 2000).where("seq < ?", 2100).to_a # Call Types
        cts.each do |item|
            item["message"].split(",").each do |word|
                if uri.downcase.include?(word.downcase)
                    call_type = item["identifier"].to_s
                    break
                end
            end
            if call_type != ""
                break
            end
        end
        return call_type # string police|fire|health based on msg input; empty if calltpye can't be identified
     end

    def translate_calltype(call_type, lang)
        tt = BotResponse.where(lang: lang, identifier: call_type).where("seq >= ?", 5000).where("seq < ?", 6000).to_a # Translation Table
        if tt.count > 0
            return tt.first["message"]
        else
            return ""
        end
    end
end

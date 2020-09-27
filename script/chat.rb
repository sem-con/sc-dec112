#!/usr/bin/env ruby
# encoding: utf-8

require 'faye/websocket'
require 'eventmachine'
require 'httparty'
# require 'eliza'
require 'json'

SC_URL = "http://localhost:3000/"
SC_DATA_URL = SC_URL + "api/data"
SC_INFO = SC_URL + "api/info"
SC_UP = SC_URL + "api/meta/usage"
SC_RECEIPT_URL = SC_URL + "api/receipt/"
SC_CHATBOT_URL = SC_URL + "api/chatbot/"
HEADERS = { 'Content-Type' => 'application/json' }

def bot_log(msg)
  p "[" + Time.now.strftime('%Y-%m-%dT%H:%M:%S.%L') + "] " + msg
end

def get_headers()
  app_key = nil
  app_secret = nil
  token = nil
  if ENV["APP_KEY"].to_s != ""
    app_key = ENV["APP_KEY"].to_s
  end
  if ENV["APP_SECRET"].to_s != ""
    app_secret = ENV["APP_SECRET"].to_s
  end

  if !app_key.nil?
    login_url = SC_URL + "oauth/token"
    response_nil = false
    begin
        response = HTTParty.post(login_url, 
            headers: { 'Content-Type' => 'application/json' },
            body: { client_id: app_key, 
                client_secret: app_secret, 
                scope: "write",
                grant_type: "client_credentials" }.to_json )
    rescue => ex
        response_nil = true
    end
    if !response_nil && !response.body.nil? && response.code == 200
        token = response.parsed_response["access_token"].to_s
        { 'Content-Type' => 'application/json',
          'Authorization' => 'Bearer ' + token }
    else
        nil
    end
  else
    nil
  end
end

def start_connection()
  # bot_log("invoke start_connection()")
  lang = ENV['CHAT_LANG'] || 'de'

  EM.run {
    call_id = nil
    # bot_log "start eventmachine"
    # ws_endpoint = ENV['WS_ENDPOINT'] || 'wss://service.dec112.at:8080/api/v1?api_key=OYD2019%23dev'
    ws_endpoint = ENV['WS_ENDPOINT'] || 'ws://10.16.77.219:8000/api/v1?api_key=CPFD2019%23dev'
    # ws_endpoint = ENV['WS_ENDPOINT'] || 'ws://dec-border.it.end_stringnet.io:8000/api/v1?api_key=CPFD2019%23dev'
    ws_protocol = ENV['WS_PROTOCOL'] || 'dec112'
    ws = Faye::WebSocket::Client.new(ws_endpoint, [ws_protocol])
    bot_log "connected to WebSocket"

    ws.on :open do |event|
      bot_log "[:open]"
      ws.send('{"method":"subscribe_new_calls"}')
    end

    ws.on :message do |event|
      event_data = JSON(event.data.to_s)
      write = false
      write_consent = false
      sc_headers = get_headers()
      case event_data["event"].to_s
      when  "new_call"
        call_id = event_data["call_id"].to_s
        begin_string = "sip:"
        end_string = "@"
        call_type = event_data["called_uri"].to_s[/#{begin_string}(.*?)#{end_string}/m, 1] rescue ""
        ws.send('{"method":"subscribe_call", "call_id":"' + call_id + '"}')
        ws.send('{"method":"get_call", "call_id":"' + call_id + '"}')
        response = HTTParty.post(SC_CHATBOT_URL + "welcome", headers: sc_headers, body: {call_id: call_id, lang: lang, calltype: call_type}.to_json )
        ws.send('{"method":"send", "call_id":"' + call_id.to_s + '", "message":"' + response.parsed_response["message"].to_s + '"}')
        write = true

      when "new_message"
        call_id = event_data["call_id"].to_s
        msg = event_data["message"]["texts"].join("\n").strip rescue ""
        origin = event_data["message"]["origin"].strip rescue ""
        if origin == "remote" && msg != ""
          response = HTTParty.post(SC_CHATBOT_URL + "reply", headers: sc_headers, body: {message: msg, call_id: call_id, lang: lang}.to_json )
          rmsg = response.parsed_response["message"].to_s
          if rmsg != ""
            if rmsg == "//dec112_exit"
              ws.send('{"method":"close_call", "call_id":"' + call_id + '"}')
            else
              if rmsg.end_with? "//dec112_exit"
                ws.send('{"method":"send", "call_id":"' + call_id + '", "message":"' + rmsg[0..(rmsg.length - "//dec112_exit".length - 1)] + '"}')
                sleep(10)
                ws.send('{"method":"close_call", "call_id":"' + call_id + '"}')
              else
                ws.send('{"method":"send", "call_id":"' + call_id + '", "message":"' + rmsg + '"}')
              end
            end
          end
        end
        write = true
        write_consent = true
      when "close_call", "state_change"
        write = true
        write_consent = true
      end

      if event_data["method"].to_s == "get_call"
        call_id = event_data["call"]["call_id"].to_s
        begin_string = "sip:"
        end_string = "@"
        call_type = event_data["call"]["called_uri"].to_s[/#{begin_string}(.*?)#{end_string}/m, 1] rescue ""
        if call_type != "" && call_id != ""
          response = HTTParty.post(SC_CHATBOT_URL + "call_type", headers: sc_headers, body: {call_id: call_id, lang: lang, calltype: call_type}.to_json )
          rmsg = response.parsed_response["message"].to_s
          if rmsg != ""
            ws.send('{"method":"send", "call_id":"' + call_id + '", "message":"' + rmsg + '"}')
          end
        end
        # event_data["caller_uri"] = event_data["caller"]
        event_data["code"] = 200

        write = true

      end

      if write
        event_data["message_received_ts"] = Time.now.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
        begin
bot_log [event_data].to_json
          post_response = HTTParty.post(SC_DATA_URL, headers: sc_headers, body: [event_data].to_json )
        rescue => ex
          post_response = nil
        end

        if write_consent
            consent_given = false
            # extract DID from messages
            did = ""
            if call_id.nil?
                call_id = event_data["call_id"]
            end
            receipt_response = HTTParty.get(SC_RECEIPT_URL + post_response.parsed_response["receipt"].to_s, headers: sc_headers) rescue nil
            complete_response = HTTParty.get(SC_DATA_URL + "/" + receipt_response.parsed_response["ids"].first.to_s, headers: sc_headers) rescue nil
            messages = complete_response.parsed_response.first["messages"] rescue nil
            curr_state = 0
            messages.each do |item|
                my_state = item["state"].to_i rescue nil
                if !my_state.nil?
                    if curr_state < my_state
                        curr_state = my_state
                    end
                end
                if !item["call"].nil?
                    if !item["call"]["did"].nil?
                        did = item["call"]["did"].to_s
                    end
                end
                if !item["message"].nil?
                    txt = item["message"]["texts"].first.to_s rescue ""
                    if txt != ""
                        # check if consent was given
                        if txt.start_with?("You have consented to the use of your inputs for training purposes in control centers.")
                            consent_given = true
                        end
                        if txt.start_with?("Sie haben der Verwendung ihrer Einaben zu Trainingszwecken in Leitzentralen zugestimmt.")
                            consent_given = true
                        end
                        if txt.start_with?("Usted ha consentido que sus datos sean usados para fines de entrenamiento.")
                            consent_given = true
                        end
                        if txt.start_with?("Vous avez accepté que vos données soient exploités par nos centres de contrôle.")
                            consent_given = true
                        end
                        if txt.start_with?("Ati confirmat utilizarea datelor dvs. in scopuri de instruire la centrala de coordonare interventii.")
                            consent_given = true
                        end
                    end
                end
            end unless messages.nil?

            if did.to_s != "" && curr_state > 3 && consent_given
                # resolve DID !!!fix me
                srv_ep_pds = "https://data-vault.eu"

                response_nil = false
                begin
                    info_response = HTTParty.get(SC_INFO, headers: sc_headers)
                    up_response = HTTParty.get(SC_UP, headers: sc_headers)
                rescue => ex
                    response_nil = true
                end
                if !response_nil
                    rec = {
                        "timestamp": Time.now.getutc.to_i,
                        "did": did,
                        "service-endpoint": info_response.parsed_response["serviceEndPoint"],
                        "service-description": info_response.parsed_response["description"],
                        "identifier": call_id.to_s,
                        "usage-policy": up_response.parsed_response.to_s,
                        "receipt": post_response.parsed_response
                    } rescue {}

                    dv_app_key = nil
                    dv_app_secret = nil
                    dv_token = nil
                    if ENV["DV_APP_KEY"].to_s != ""
                        dv_app_key = ENV["DV_APP_KEY"].to_s
                    end
                    if ENV["DV_APP_SECRET"].to_s != ""
                        dv_app_secret = ENV["DV_APP_SECRET"].to_s
                    end

                    dv_headers = {}
                    if !dv_app_key.nil? && !dv_app_secret.nil?
                        login_url = srv_ep_pds + "/oauth/token"
                        response_nil = false
                        begin
                            response = HTTParty.post(login_url, 
                                headers: { 'Content-Type' => 'application/json' },
                                body: { client_id: dv_app_key, 
                                    client_secret: dv_app_secret,
                                    grant_type: "client_credentials" }.to_json )
                        rescue => ex
                            response_nil = true
                        end
                        if !response_nil && !response.body.nil? && response.code == 200
                            dv_token = response.parsed_response["access_token"].to_s
                            dv_headers = { 'Content-Type' => 'application/json',
                                           'Authorization' => 'Bearer ' + dv_token }
                        end
                        response = HTTParty.post(srv_ep_pds + "/api/consent", headers: dv_headers, body: rec.to_json )
                    end
                end
            end
        end
      end
    end

    ws.on :close do |event|
      bot_log "close event"
      p [:close, event.code, event.reason]
      ws = nil
      sleep(1)
      bot_log "initiate re-connect"
      start_connection
    end
  }
end

start_connection
#!/usr/bin/env ruby
# encoding: utf-8

require 'faye/websocket'
require 'eventmachine'
require 'httparty'
require 'eliza'
require 'json'

SC_URL = "http://localhost:3000/api/data"
HEADERS = { 'Content-Type' => 'application/json' }

eliza = Eliza::Bot.new

EM.run {
  ws_endpoint = ENV['WS_ENDPOINT'] || 'wss://service.dec112.at:8080/api/v1?api_key=OYD2019%23dev'
  ws_protocol = ENV['WS_PROTOCOL'] || 'dec112'
  ws = Faye::WebSocket::Client.new(ws_endpoint, [ws_protocol])

  ws.on :open do |event|
    p [:open]
    ws.send('{"method":"subscribe_new_calls"}')
  end

  ws.on :message do |event|
    # puts event.data.to_json
    # puts "event.data: " + JSON(event.data.to_s)["event"].to_s
    event_data = JSON(event.data.to_s)
    write = false
    case event_data["event"].to_s
    when  "new_call"
      call_id = event_data["call_id"].to_s
      ws.send('{"method":"subscribe_call", "call_id":"' + call_id + '"}')
      ws.send('{"method":"get_call", "call_id":"' + call_id + '"}')
      ws.send('{"method":"send", "call_id":"' + call_id + '", "message":"' + eliza.initial_phrase + '"}')

      write = true
    when "new_message"
      call_id = event_data["call_id"].to_s
      msg = event_data["message"]["texts"].join("\n").strip rescue ""
      origin = event_data["message"]["origin"].strip rescue ""
      # puts call_id + " (" + origin + "): " + msg
      if origin == "remote"
        ws.send('{"method":"send", "call_id":"' + call_id + '", "message":"' + eliza.transform(msg) + '"}')
      else
        # if eliza.bye?
        #   sleep(5)
        #   ws.send('{"method":"close_call", "call_id":"' + call_id + '"}')
        # end
      end
      write = true
    when "close_call", "state_change"
      write = true
    end

    if event_data["method"].to_s == "get_call"
      write = true
    end

    if write
      begin
        post_response = HTTParty.post(SC_URL, headers: HEADERS, body: [event_data].to_json )
      rescue => ex
        post_response = nil
      end
    end
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}
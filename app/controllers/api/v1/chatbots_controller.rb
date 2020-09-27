module Api
    module V1
        class ChatbotsController < ApiController
            # respond only to JSON requests
            respond_to :json
            respond_to :html, only: []
            respond_to :xml, only: []

            include ChatbotHelper
            include CalltypeHelper

            def welcome
                msg = ""
                item = BotResponse.where(identifier: "welcome", lang: params[:lang])
                if item.count > 0
                    msg = item.first.message
                end
                ct = params[:calltype].to_s
                if ct != ""
                    ct = map_uri_calltype(ct)
                end
                content = { message: msg_placeholder_completion(msg, params[:call_id], params[:lang], ct) }
                render json: content, 
                       status: 200
            end

            def call_type
                msg = ""
                item = BotResponse.where(identifier: "call_type", lang: params[:lang])
                if item.count > 0
                    msg = item.first.message
                end
                ct = params[:calltype].to_s
                if ct != ""
                    ct = map_uri_calltype(ct)
                end
                if ct != ""
                    content = { message: msg_placeholder_completion(msg, params[:call_id], params[:lang], ct) }
                    render json: content, 
                           status: 200
                else
                    render json: { message: "" },
                           status: 200
                end
            end

            def reply
                content = { message: dec112_reply(params[:message], params[:call_id], params[:lang]) }
                render json: content, 
                       status: 200
            end
        end
    end
end
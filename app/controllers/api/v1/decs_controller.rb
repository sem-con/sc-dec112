module Api
    module V1
        class DecsController < ApiController
            # respond only to JSON requests
            respond_to :json
            respond_to :html, only: []
            respond_to :xml, only: []

            def index
                content = []
                Store.pluck(:item).each do |item|
                    record = JSON(item)
                    duration = Time.at(record["end_ts"].to_datetime.to_i - record["created_ts"].to_datetime.to_i).utc.strftime("%H:%M:%S") rescue ""
                    content << { 
                        "call_id": record["call_id"],
                        "caller_uri": record["caller_uri"],
                        "created_ts": record["created_ts"],
                        "duration": duration,
                        "message_count": record["messages"].count
                    }
                end 
                render json: content, 
                       status: 200

            end

            def show
                content = []
                Store.pluck(:item).each do |item|
                    record = JSON(item)
                    if record["call_id"].to_s == params[:id]
                        content = record
                    end
                end                 

                render json: content, 
                       status: 200

            end
        end
    end
end
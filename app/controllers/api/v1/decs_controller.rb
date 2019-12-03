module Api
    module V1
        class DecsController < ApiController
            # respond only to JSON requests
            respond_to :json
            respond_to :html, only: []
            respond_to :xml, only: []

            def index
                render json: {"hello": "world"}, 
                       status: 200

            end

            def show
                render json: {"hello": params[:id].to_s}, 
                       status: 200

            end
        end
    end
end
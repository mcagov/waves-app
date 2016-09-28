module Api
  module V1
    class ClientSessionsController < ApiController
      def create
        @client_session = ClientSession.create(validate_owner_params)

        if @client_session
          render status: :created
        else
          render status: 404
        end
      end

      private

      def validate_owner_params
        data = params.require("data")
        data.require(:attributes).permit([:vessel_reg_no, :client_session_id])
      end
    end
  end
end

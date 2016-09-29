module Api
  module V1
    class ClientSessionsController < ApiController
      def create
        @client_session = ClientSession.new(validate_owner_params)

        if @client_session.save
          render status: :created
        else
          render status: 404
        end
      end

      private

      def validate_owner_params
        data = params.require("data")
        data.require(:attributes).permit(
          [:vessel_reg_no, :external_session_key])
      end
    end
  end
end

module Api
  module V1
    class ClientSessionsController < ApiController
      def create
        @client_session = ClientSession.new(client_session_params)

        if @client_session.save
          render json: @client_session, status: :created
        else
          render status: 404
        end
      end

      private

      def client_session_params
        params.require("data").require(:attributes).permit(
          [:vessel_reg_no, :email, :external_session_key])
      end
    end
  end
end

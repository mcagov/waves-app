module Api
  module V1
    class VesselsController < ApiController
      def show
        @vessel = load_vessel

        if @vessel
          render json: @vessel
        else
          render status: 404
        end
      end

      private

      def load_vessel
        if params[:filter] && params[:filter][:reg_no]
          Register::Vessel.find_by(reg_no: params[:filter][:reg_no])

        elsif params[:id]
          load_from_client_session
        end
      end

      def load_from_client_session
        vessel_params = params[:id].split(";")

        client_session = ClientSession.find_by(
          access_code: vessel_params[0],
          external_session_key: vessel_params[1])

        client_session.registered_vessel if client_session
      end
    end
  end
end

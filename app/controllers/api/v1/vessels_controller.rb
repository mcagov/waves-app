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

      def vessel_params
        params[:id].split(";")
      end

      def load_vessel
        client_session = ClientSession.find_by(
          vessel_reg_no: vessel_params[0],
          access_code: vessel_params[1],
          external_session_key: vessel_params[2])

        client_session.vessel if client_session
      end
    end
  end
end

module Api
  module V1
    class VesselsController < ApiController
      def show
        vessel_reg_no = params[:id].split(";")

        # validate and delete the client_session
        @vessel = Register::Vessel.where(reg_no: vessel_reg_no).first

        if @vessel
          render json: @vessel
        else
          render status: 404
        end
      end
    end
  end
end

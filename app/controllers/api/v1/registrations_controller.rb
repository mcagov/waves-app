module Api::V1
  class RegistrationsController < ApiController
    def create

      @registration = Registration.create(registration_attributes)

      render json: @registration
    end


    private

    def registration_params
      params.require(:attributes).permit(:type, :status)
    end


    def registration_attributes
      registration_params[:attributes] || {}
    end
  end
end

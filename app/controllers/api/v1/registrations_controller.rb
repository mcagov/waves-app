module Api::V1
  class RegistrationsController < ApiController
    def create
      @registration = Registration.new(create_registration_params)

      if @registration.save
        render json: @registration, status: :created
      else
        render json: @registration, status: :unprocessable_entity,
                       serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end

    private

    def create_registration_params
      data = params.require("data")
      data.require(:attributes).permit!
    end
  end
end

module Api
  module V1
    class NewRegistrationsController < ApiController
      def create
        @new_registration =
          Submission::NewRegistration.new(create_new_registration_params)

        if @new_registration.save
          render json: @new_registration, status: :created
        else
          render json: @new_registration,
                 status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      private

      def create_new_registration_params
        data = params.require("data")
        data.require(:attributes).permit!
      end
    end
  end
end

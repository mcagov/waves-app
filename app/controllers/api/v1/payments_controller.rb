module Api::V1
  class PaymentsController < ApiController
    def create
      @payment = Payment.new(create_payment_params)

      if @payment.save
        render json: @payment, status: :created
      else
        render json: @payment, status: :unprocessable_entity,
                       serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end

    private

    def create_payment_params
      data = params.require("data")
      data.require(:attributes).permit!
    end
  end
end

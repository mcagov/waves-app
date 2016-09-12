module Api
  module V1
    class PaymentsController < ApiController
      def create
        @payment = Payment.new(create_payment_params)

        if @payment.save
          create_application_receipt_notification
          render json: @payment, status: :created
        else
          render json: @payment, status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      private

      def create_payment_params
        data = params.require("data")
        data.require(:attributes).permit(
          :submission_id, :wp_token, :wp_order_code,
          :wp_amount, :wp_country, :customer_ip)
      end

      def create_application_receipt_notification
        Notification::ApplicationReceipt.create(
          notifiable: submission,
          recipient_name: submission.applicant,
          recipient_email: submission.applicant_email
        )
      end

      def submission
        @submission ||= @payment.submission
      end
    end
  end
end

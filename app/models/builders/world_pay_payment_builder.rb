class Builders::WorldPayPaymentBuilder
  class << self
    def create(wp_params)
      @wp_params = wp_params

      Payment.create(
        submission_id:  @wp_params[:submission_id],
        amount: @wp_params[:wp_amount],
        remittance: create_world_pay_payment)
    end

    private

    def create_world_pay_payment
      Payment::WorldPay.create(
        wp_token: @wp_params[:wp_token],
        wp_order_code:  @wp_params[:wp_order_code],
        wp_country: @wp_params[:wp_country],
        customer_ip: @wp_params[:customer_ip],
        wp_payment_response: @wp_params[:wp_payment_response]
      )
    end
  end
end

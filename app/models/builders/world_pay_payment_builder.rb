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
      Payment::WorldPay.create(customer_ip: @wp_params[:customer_ip])
    end
  end
end

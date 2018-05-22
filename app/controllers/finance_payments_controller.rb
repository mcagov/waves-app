class FinancePaymentsController < InternalPagesController
  def update
    @finance_payment = Payment::FinancePayment.find(params[:id])
    @finance_payment.update_attributes(finance_payment_params)

    respond_to do |format|
      format.js do
        @finance_payment = Decorators::FinancePayment.new(@finance_payment)
      end
    end
  end

  private

  def finance_payment_params
    params.require(:payment_finance_payment).permit(:documents_received)
  end
end

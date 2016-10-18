class Finance::PaymentsController < InternalPagesController
  def new
    @payment = FinancePayment.new
  end

  def create
    @finance_payment = FinancePayment.new(payment_params)
    @submission = @finance_payment.create_submission

    flash[:notice] = "Application successfully saved.\
                     Write this number on the paperwork: \
                     #{@submission.ref_no}"

    redirect_to finance_submission_path(@submission)
  end

  protected

  def payment_params
    params.require(:finance_payment).permit(
      :part, :task, :vessel_reg_no, :vessel_name, :service_level,
      :payment_type, :payment_amount, :receipt_no, :applicant_name,
      :applicant_email, :documents_received)
  end
end

class Finance::PaymentsController < InternalPagesController
  def new
    @finance_payment = Payment::FinancePayment.new
  end

  def create
    @finance_payment = Payment::FinancePayment.new(finance_payment_params)
    @finance_payment.actioned_by = current_user

    if @finance_payment.save
      flash[:notice] = "Application successfully saved.\
                       Write this number on the paperwork: \
                       #{@finance_payment.submission_ref_no}"
      redirect_to finance_payment_path(@finance_payment)
    else
      render :new
    end
  end

  protected

  def finance_payment_params
    params.require(:payment_finance_payment).permit(
      :part, :task, :vessel_reg_no, :vessel_name, :service_level,
      :payment_type, :payment_amount, :receipt_no, :applicant_name,
      :applicant_email, :documents_received)
  end
end

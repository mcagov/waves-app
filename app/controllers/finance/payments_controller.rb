class Finance::PaymentsController < InternalPagesController
  def new
    @finance_payment = Payment::FinancePayment.new
  end

  def show
    @prompt_success = (params[:prompt] == "success")
    finance_payment = Payment::FinancePayment.find(params[:id])
    @finance_payment = Decorators::FinancePayment.new(finance_payment)
  end

  def create
    @finance_payment = Payment::FinancePayment.new(finance_payment_params)
    @finance_payment.actioned_by = current_user

    if @finance_payment.save

      redirect_to finance_payment_path(@finance_payment, prompt: :success)
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

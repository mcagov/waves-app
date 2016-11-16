class Finance::PaymentsController < InternalPagesController
  def new
    @finance_payment = Payment::FinancePayment.new(payment_date: Date.today)
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
      Notification::PaymentReceipt.create(notification_params)

      redirect_to finance_payment_path(@finance_payment, prompt: :success)
    else
      render :new
    end
  end

  def index
    @finance_payments =
      Payment::FinancePayment.paginate(page: params[:page], per_page: 20)
  end

  protected

  def finance_payment_params
    params.require(:payment_finance_payment).permit(
      :submission_ref_no,
      :payment_date, :part, :task, :vessel_reg_no, :vessel_name,
      :service_level, :payment_type, :payment_amount, :receipt_no,
      :applicant_name, :applicant_email, :documents_received)
  end

  def notification_params
    {
      notifiable: @finance_payment,
      actioned_by: current_user,
      recipient_email: @finance_payment.applicant_email,
      recipient_name: @finance_payment.applicant_name,
    }
  end
end

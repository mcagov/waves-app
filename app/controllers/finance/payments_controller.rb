class Finance::PaymentsController < InternalPagesController
  before_action :load_batch

  def new
    @finance_payment = Payment::FinancePayment.new(payment_date: Date.today)
  end

  def show
    @prompt_success = (params[:prompt] == "success")
    @prompt_update = (params[:prompt] == "update")
    finance_payment = Payment::FinancePayment.find(params[:id])
    @finance_payment = Decorators::FinancePayment.new(finance_payment)
  end

  def edit
    @finance_payment = Payment::FinancePayment.find(params[:id])
  end

  def create
    @finance_payment = Payment::FinancePayment.new(finance_payment_params)
    @finance_payment.actioned_by = current_user
    @finance_payment.batch = @batch

    if @finance_payment.save
      redirect_to finance_batch_payment_path(
        @batch, @finance_payment, prompt: :success)
    else
      render :new
    end
  end

  def update
    @finance_payment = Payment::FinancePayment.find(params[:id])
    @finance_payment.actioned_by = current_user

    if @finance_payment.update_attributes(finance_payment_params)
      redirect_to finance_batch_payment_path(
        @batch, @finance_payment, prompt: :update)
    else
      render :edit
    end
  end

  def index
    @finance_payments =
      @batch.finance_payments.paginate(page: params[:page], per_page: 20)
  end

  protected

  def finance_payment_params
    params.require(:payment_finance_payment).permit(
      :payment_date, :application_ref_no, :part,
      :task, :vessel_reg_no, :vessel_name,
      :service_level, :payment_type, :payment_amount, :applicant_is_agent,
      :applicant_name, :applicant_email, :documents_received)
  end

  def load_batch
    @batch = FinanceBatch.includes(finance_payments: [:payment])
                         .find(params[:batch_id])
  end
end

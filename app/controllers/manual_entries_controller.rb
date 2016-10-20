class ManualEntriesController < InternalPagesController
  before_action :load_submission
  before_action :load_finance_payment

  def show; end

  def update
    @submission =
      Builders::ManualEntryBuilder.convert_to_application(@submission)
    redirect_to edit_submission_path(@submission)
  end

  protected

  def load_submission
    @submission = Submission.find(params[:id])
  end

  def load_finance_payment
    if @submission.payment
      @finance_payment =
        Decorators::FinancePayment.new(@submission.payment.remittance)
    end
  end
end

class ManualEntriesController < InternalPagesController
  before_action :load_submission, except: [:new, :create]

  def show
    if @submission.payment
      @finance_payment =
        Decorators::FinancePayment.new(@submission.payment.remittance)
    end
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)
    @submission.part = current_activity.part
    @submission.claimant = current_user
    @submission.state = :assigned
    @submission.save

    redirect_to edit_submission_path(@submission)
  end

  def convert_to_application
    @submission =
      Builders::ManualEntryBuilder.convert_to_application(@submission)
    redirect_to edit_submission_path(@submission)
  end

  protected

  def load_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:task, :vessel_reg_no)
  end
end

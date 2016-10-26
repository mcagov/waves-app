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

    if @submission.save
      redirect_to edit_submission_path(@submission)
    else
      render :new
    end
  end

  def convert_to_application
    @submission =
      Builders::ManualEntryBuilder.convert_to_application(@submission)
    redirect_to edit_submission_path(@submission)
  end

  def edit; end

  def update
    @original_submission_part = @submission.part
    if @submission.update_attributes(submission_params)
      succcessful_redirect_after_update
    else
      render :edit
    end
  end

  protected

  def load_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:part, :task, :vessel_reg_no)
  end

  def succcessful_redirect_after_update
    if @original_submission_part == @submission.part
      flash[:notice] = "The application has been updated"
      redirect_to submission_path(@submission)
    else
      @submission.unclaimed!
      flash[:notice] = "The application has been moved\
                       to #{Activity.new(@submission.part)}"
      redirect_to tasks_my_tasks_path
    end
  end
end

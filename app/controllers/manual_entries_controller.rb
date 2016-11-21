class ManualEntriesController < InternalPagesController
  before_action :load_submission, except: [:new, :create]

  def show
    if @submission.payment
      @finance_payment =
        Decorators::FinancePayment.new(@submission.payment.remittance)
    end
  end

  def new
    @submission = Submission.new(part: current_activity.part)
  end

  def convert_to_application
    @submission.officer_intervention_required = false
    @submission.ref_no = RefNo.generate_for(@submission)

    if @submission.save
      redirect_to submission_path(@submission)
    else
      render :edit
    end
  end

  def edit; end

  def update
    @original_submission_part = @submission.part
    @submission.assign_attributes(submission_params)

    if @submission.save
      redirect_to submission_path(@submission)
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
end

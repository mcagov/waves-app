class Submission::FinancePaymentsController < InternalPagesController
  before_action :load_submission

  def show; end

  def convert
    @submission.officer_intervention_required = false
    @submission.ref_no = RefNo.generate_for(@submission)

    if @submission.save
      redirect_to submission_path(@submission)
    else
      @submission.officer_intervention_required = true
      render :edit
    end
  end

  def edit; end

  def update
    @submission.assign_attributes(submission_params)
    convert
  end

  protected

  def load_submission
    @submission = Submission.find(params[:submission_id])
  end

  def submission_params
    params.require(:submission).permit(:task, :vessel_reg_no)
  end
end

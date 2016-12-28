class Submission::FinancePaymentsController < InternalPagesController
  before_action :load_submission
  before_action :load_linkable_submission

  def show; end

  def convert
    @submission.officer_intervention_required = false
    @submission.ref_no = RefNo.generate_for(@submission)

    if @submission.save
      create_notification

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

  def load_linkable_submission
    linkable_ref_no = @submission.symbolized_changeset[:linkable_ref_no]
    @linkable_submission =
      Submission.find_by(ref_no: linkable_ref_no) if linkable_ref_no
  end

  def submission_params
    params.require(:submission).permit(:task, :vessel_reg_no)
  end

  def create_notification
    Notification::ApplicationReceipt.create(
      notifiable: @submission,
      recipient_name: @submission.applicant_name,
      recipient_email: @submission.applicant_email,
      actioned_by: current_user)
  end
end

class Submission::NameApprovalsController < InternalPagesController
  before_action :load_submission
  before_action :load_name_approval

  def show; end

  def update
    @name_approval.assign_attributes(name_approval_params)
    @name_validated = @name_approval.valid?

    if @name_validated && params[:name_validated]
      Builders::NameApprovalBuilder.create(@submission, @name_approval)
      build_notification
      log_work!(@submission, @submission, :name_approval)
      return redirect_to edit_submission_path(@submission)
    end

    render :show
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part).find(params[:submission_id])
  end

  def load_name_approval
    @name_approval = @submission.name_approval
    @name_approval ||=
      Submission::NameApproval.new(
        submission: @submission,
        part: @submission.part,
        name: @submission.vessel.name,
        port_code: @submission.vessel.port_code,
        port_no: @submission.vessel.port_no,
        registration_type: @submission.vessel.registration_type)
  end

  def name_approval_params
    params.require(:submission_name_approval).permit(
      :part, :name, :registration_type, :port_code, :port_no,
      :approved_until)
  end

  def build_notification
    Notification::NameApproval.create(
      recipient_email: @submission.applicant_email,
      recipient_name: @submission.applicant_name,
      notifiable: @submission,
      actioned_by: current_user)
  end
end

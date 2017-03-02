class Submission::NameApprovalsController < InternalPagesController
  before_action :load_submission

  def show
    @name_approval =
      Submission::NameApproval.new(part: @submission.part)
  end

  def update
    @name_approval = Submission::NameApproval.new(name_approval_params)
    @name_approval.submission = @submission
    @name_validated = @name_approval.valid?

    if @name_validated && params[:name_validated]
      @name_approval.save
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

  def name_approval_params
    params.require(:submission_name_approval).permit(
      :part, :name, :registration_type, :port_code, :port_no)
  end
end

class Submission::NameApprovalsController < InternalPagesController
  before_action :load_submission
  before_action :load_task
  before_action :enable_readonly, only: [:show]
  before_action :load_name_approval

  def show; end

  def update
    @name_approval.assign_attributes(name_approval_params)
    @name_validated = @name_approval.valid?

    if @name_validated && params[:name_validated]
      return process_update
    elsif params[:skip_name_validation] == "true"
      return process_update(false)
    end

    render :show
  end

  def destroy
    @name_approval.update_attribute(:cancelled_at, Time.zone.now)
    flash[:notice] = "The approved name has been cancelled"

    redirect_to(submission_path(@submission))
  end

  protected

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

  def process_update(perform_validations = true)
    Builders::NameApprovalBuilder.create(
      @submission, @name_approval, perform_validations)
    log_work!(@task, @task, :name_approved)
    redirect_to submission_task_path(@submission, @task)
  end
end

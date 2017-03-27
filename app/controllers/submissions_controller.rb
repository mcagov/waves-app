class SubmissionsController < InternalPagesController
  before_action :load_submission,
                only: [:show, :edit, :update]
  before_action :check_redirection_policy,
                only: [:show, :edit, :update]

  def new
    @submission =
      Submission.new(
        submission_params.merge(
          state: :initializing,
          received_at: Date.today,
          part: current_activity.part))
  end

  def create
    init_new_submission

    if @submission.save
      send_application_receipt_email
      flash[:notice] ||=
        "The application has been saved to the unclaimed tasks queue"
      redirect_to tasks_my_tasks_path
    else
      render :new
    end
  end

  def show
    @readonly = Policies::Actions.readonly?(@submission, current_user)
    @submission = Decorators::Submission.new(@submission)
  end

  def edit
    @submission = Decorators::Submission.new(@submission)
  end

  def update
    if @submission.update_attributes(submission_params)
      render_update_js
    else
      render :edit
    end
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part).includes(
        [
          { payments: [:remittance] }, { declarations: [:notification] },
          { declaration_groups: [:declarations] },
          { documents: [:assets, :actioned_by] },
          { work_logs: [:actioned_by] },
          { mortgages: [:mortgagees] }, :carving_and_markings, :managers,
          :declarations, :engines, :correspondences,
          :notifications, :beneficial_owners]).find(params[:id])
  end

  def submission_params
    return {} unless params[:submission]
    params.require(:submission).permit(
      :part, :task, :received_at, :applicant_name, :applicant_is_agent,
      :applicant_email, :vessel_reg_no, :documents_received,
      vessel: [Submission::Vessel::ATTRIBUTES, propulsion_system: []],
      delivery_address: Submission::DeliveryAddress::ATTRIBUTES
    )
  end

  def check_redirection_policy
    if Task.new(@submission.task).issues_csr?
      return redirect_to submission_csr_path(@submission)

    elsif @submission.officer_intervention_required?
      return redirect_to submission_finance_payment_path(@submission)

    elsif Policies::Workflow.approved_name_required?(@submission)
      return redirect_to submission_name_approval_path(@submission)
    end
  end

  def send_application_receipt_email
    return unless params[:new_submission_actions] == "application_receipt"

    Notification::ApplicationReceipt.create(
      notifiable: @submission,
      recipient_name: @submission.applicant_name,
      recipient_email: @submission.applicant_email,
      actioned_by: current_user)

    flash[:notice] =
      "An Application Receipt has been sent to #{@submission.applicant_email}"
  end

  def init_new_submission
    if params[:submission][:task].to_sym != :new_registration
      params[:submission].delete(:vessel)
    end

    @submission = Submission.new(submission_params)
    @submission.source = :manual_entry
    @submission.state = :unassigned
  end

  def render_update_js
    respond_to do |format|
      format.html do
        flash[:notice] = "The application has been updated"
        redirect_to submission_path(@submission)
      end
      format.js do
        view_mode = Activity.new(@submission.part).view_mode
        render "/submissions/#{view_mode}/forms/update.js"
      end
    end
  end
end

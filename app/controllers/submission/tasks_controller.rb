class Submission::TasksController < InternalPagesController
  include TaskProcessing

  before_action :load_submission
  before_action :load_task, except: [:index, :create, :confirm]
  before_action :check_task_processing_rules, only: [:show, :edit]
  before_action :enable_readonly, only: [:show, :edit]

  def index
    @tasks = @submission
             .tasks.includes(:submission, :service)
             .order(:submission_ref_counter)
  end

  def create
    @submission_task = Submission::Task.new(submission_task_params)
    @submission_task.submission = @submission
    @submission_task.save

    flash[:notice] = "The task has been added"
    redirect_to submission_tasks_path(@submission)
  end

  def confirm
    @submission.tasks.initialising.map(&:confirm!)

    flash[:notice] = "The tasks have been confirmed"
    redirect_to unattached_payments_finance_payments_path
  end

  def destroy
    @task.destroy

    flash[:notice] = "The task has been confirmed"
    redirect_to submission_tasks_path(@submission)
  end

  def update
    @task.update_attributes(submission_task_params)

    flash[:notice] = "The task has been updated"
    redirect_to submission_tasks_path(@submission)
  end

  def show
    @submission = Decorators::Submission.new(@submission)
  end

  def claim
    @task.claim!(current_user)

    respond_to do |format|
      format.html do
        flash[:notice] = "You have successfully claimed this task"
        redirect_to submission_task_path(@submission, @task)
      end
      format.js { render "tasks/actions/claim_button" }
    end
  end

  def unclaim
    @task.unclaim!

    respond_to do |format|
      format.html do
        flash[:notice] = "Task has been moved into Unclaimed Tasks"
        redirect_to tasks_my_tasks_path
      end
      format.js { render "tasks/actions/claim_button" }
    end
  end

  def claim_referral
    @task.claim_referral!(current_user)

    log_work!(@task, @submission, :referral_reclaimed)
    flash[:notice] = "You have successfully claimed that task"
    redirect_to tasks_my_tasks_path
  end

  def validate
    @validation_errors = Policies::Validations.new(@task).errors
    respond_to do |format|
      format.js do
        if @validation_errors.empty?
          render "submission/tasks/modals/complete"
        else
          render "submission/tasks/modals/validation_errors"
        end
      end
    end
  end

  def complete
    @task.complete!(submission_task_params || {})

    log_work!(@task, @submission, :task_completed)
    StaffPerformanceLog.record(@task, :completed, current_user)
    flash[:notice] = "The task has been completed"
    redirect_to submission_path(@submission)
  end

  private

  def submission_task_params
    return {} unless params[:submission_task]
    params.require(:submission_task).permit(
      :service_id, :service_level, :start_date,
      :price_in_pounds,
      :registration_starts_at, :registration_ends_at,
      :closure_at, :closure_reason, :supporting_info)
  end

  def load_task
    @task = @submission.tasks.find(params[:id])
  end
end

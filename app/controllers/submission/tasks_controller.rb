class Submission::TasksController < InternalPagesController
  before_action :load_submission
  before_action :load_task, only: [:destroy, :update]
  def index
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
    redirect_to submission_tasks_path(@submission)
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

  private

  def submission_task_params
    params.require(:submission_task).permit(
      :service_id, :service_level, :start_date)
  end

  def load_task
    @task = @submission.tasks.find(params[:id])
  end
end

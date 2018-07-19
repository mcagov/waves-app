class Submission::TasksController < InternalPagesController
  before_action :load_submission

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

  private

  def submission_task_params
    params.require(:submission_task).permit(:service_id, :price, :service_level)
  end
end

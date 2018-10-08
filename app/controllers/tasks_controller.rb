class TasksController < InternalPagesController
  def my_tasks
    @tasks =
      task_scope.claimed_by(current_user).order("target_date asc")
  end

  def team_tasks
    @tasks = task_scope.claimed.order("target_date asc")
  end

  def unclaimed
    @tasks = task_scope.unclaimed.order("target_date asc")
  end

  def incomplete
    @tasks = task_scope.incomplete.order("target_date asc")
  end

  def referred
    @tasks = task_scope.order("submission_tasks.referred_until desc").referred
  end

  def cancelled
    @tasks = task_scope.order("submission_tasks.updated_at desc").cancelled
  end

  def next_task
    if (task = task_scope.claimed_by(current_user).first)
      return redirect_to submission_task_path(task.submission, task)
    else
      return redirect_to tasks_my_tasks_path
    end
  end

  private

  def task_scope
    task_scope =
      Submission::Task
      .in_part(current_activity.part)
      .includes(:claimant, :submission, :service)
      .paginate(page: params[:page], per_page: 50)

    task_scope = task_scope.service_level(params[:filter_service_level])
    task_scope.registration_type(params[:filter_registration_type])
  end
end

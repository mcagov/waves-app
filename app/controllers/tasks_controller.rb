class TasksController < InternalPagesController
  def my_tasks
    @tasks =
      task_scope.assigned_to(current_user).order("target_date asc")
  end

  def team_tasks
    @tasks = task_scope.assigned.order("target_date asc")
  end

  def unclaimed
    @filter_registration_type = params[:filter_registration_type] || "all"

    query =
      task_scope
      .unassigned

    query = filter_by_registration_type(query)
    @tasks = query.order("target_date asc")
  end

  def incomplete
    @tasks = task_scope.incomplete.order("target_date asc")
  end

  def referred
    @tasks = task_scope.order("referred_until desc").referred
  end

  def cancelled
    @tasks = task_scope.order("updated_at desc").cancelled
  end

  def next_task
    if (task = task_scope.assigned_to(current_user).first)
      return redirect_to task_path(task)
    else
      return redirect_to tasks_my_tasks_path
    end
  end

  private

  def task_scope
    Submission::Task
      .in_part(current_activity.part)
      .includes(:claimant, :submission, :service)
      .paginate(page: params[:page], per_page: 50)
      .active
  end

  def filter_by_registration_type(query)
    case @filter_registration_type
    when "all"
      query
    when "not_set"
      query.where("(changeset#>>'{vessel_info, registration_type}' is null)")
    else
      query.where(
        "(UPPER(changeset#>>'{vessel_info, registration_type}') = ?)",
        @filter_registration_type.upcase)
    end
  end
end

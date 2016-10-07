class TasksController < InternalPagesController
  def my_tasks
    @submissions = submission_scope.assigned_to(current_user)
  end

  def team_tasks
    @submissions = submission_scope.assigned
  end

  def unclaimed
    @submissions = submission_scope.unassigned
  end

  def incomplete
    @submissions = submission_scope.incomplete
  end

  def referred
    @submissions = submission_scope.order("referred_until desc").referred
  end

  def rejected
    @submissions = submission_scope.order("updated_at desc").rejected
  end

  def cancelled
    @submissions = submission_scope.order("updated_at desc").cancelled
  end

  def next_task
    # rubocop: disable Style/GuardClause
    if (submission = submission_scope.assigned_to(current_user).first)
      return redirect_to submission_path(submission)
    else
      return redirect_to tasks_my_tasks_path
    end
  end

  private

  def submission_scope
    Submission
      .order("target_date asc")
      .where.not(state: [:printing, :completed])
  end
end

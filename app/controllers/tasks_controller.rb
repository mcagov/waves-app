class TasksController < InternalPagesController
  def my_tasks
    @submissions = Submission.assigned_to(current_user)
  end

  def team_tasks
    @submissions = Submission.assigned
  end

  def unclaimed
    @submissions = Submission.unassigned
  end

  def print_queue
    @submissions = []
  end

  def incomplete
    @submissions = Submission.incomplete
  end

  def referred
    @submissions = Submission.order("referred_until desc").referred
  end

  def rejected
    @submissions = Submission.order("updated_at desc").rejected
  end

  def cancelled
    @submissions = Submission.order("updated_at desc").cancelled
  end

  def next_task
    if (submission = Submission.assigned_to(current_user).first)
      return redirect_to submission_path(submission)
    else
      return redirect_to tasks_my_tasks_path
    end
  end
end

class TasksController < InternalPagesController

  def my_tasks
    @submissions = Submission.assigned_to(current_user)
  end

  def team_tasks
    @submissions = []
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
    @submissions = Submission.order('referred_until desc').referred
  end

  def rejected
    @submissions = Submission.order('updated_at desc').rejected
  end
end

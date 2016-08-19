class TasksController < InternalPagesController

  def my_tasks
    @submissions = []
  end

  def team_tasks
    @submissions = []
  end

   def unclaimed
    @submissions = Submission.includes([:payment]).unassigned
  end

  def print_queue
    @submissions = []
  end

  def incomplete
    @submissions = Submission.incomplete
  end

  def referred
    @submissions = []
  end
end

class TasksController < InternalPagesController

  def unclaimed
    @submissions = Submission.includes([:vessel, :payment]).all
  end

  def mine
  end
end

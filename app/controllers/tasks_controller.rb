class TasksController < InternalPagesController
  before_action :load_submissions


  protected

  def load_submissions
    @submissions = Submission.includes([:vessel, :payment]).all
  end
end

class TasksController < InternalPagesController
  before_action :load_submissions


  protected

  def load_submissions
    @submissions = Submission.includes([:payment]).all
  end
end

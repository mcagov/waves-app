class ManualEntriesController < InternalPagesController
  before_action :load_submission

  def edit; end

  protected

  def load_submission
    @submission = Submission.find(params[:id])
  end
end

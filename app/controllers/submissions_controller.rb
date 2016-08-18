class SubmissionsController < InternalPagesController
  def show
    @submission = Submission.includes(:payment).find(params[:id])
  end
end

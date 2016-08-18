class SubmissionsController < InternalPagesController
  def show
    @submission = Submission.includes([:vessel, :payment]).find(params[:id])
  end
end

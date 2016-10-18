class Finance::SubmissionsController < InternalPagesController
  def show
    submission = Submission.includes(
      [:payments, :correspondences, :notifications]).find(params[:id])

    @submission = Decorators::Submission.new(submission)
  end
end

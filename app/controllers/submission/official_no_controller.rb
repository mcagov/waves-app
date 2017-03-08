class Submission::OfficialNoController < InternalPagesController
  def update
    @submission = Submission.find(params[:submission_id])
    Builders::OfficialNoBuilder.build(@submission)

    redirect_to @submission
  end
end

class CorrespondencesController < InternalPagesController
  before_action :load_submission

  def create
    @correspondence = Correspondence.new(correspondence_params)
    @correspondence.actioned_by = current_user
    @correspondence.noteable = @submission

    if @correspondence.save
      flash[:notice] = "The correspondence has been saved"
    end
    redirect_to submission_path(@submission)

  end

  private

  def load_submission
    @submission = Submission.find(params[:submission_id])
  end

  def correspondence_params
    params.require(:correspondence).permit(:subject, :format, :noted_at, :content)
  end
end

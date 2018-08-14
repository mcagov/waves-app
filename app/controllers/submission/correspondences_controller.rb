class Submission::CorrespondencesController < InternalPagesController
  before_action :load_submission
  before_action :load_task

  def create
    @correspondence = Correspondence.new(correspondence_params)
    @correspondence.actioned_by = current_user
    @correspondence.noteable = @submission

    flash[:notice] = "The correspondence has been saved" if @correspondence.save

    redirect_to submission_task_path(@submission, @task)
  end

  def destroy
    @correspondence = Correspondence.find(params[:correspondence_id])
    if @correspondence
      @correspondence.destroy
      flash[:notice] = "That item of correspondence has been removed"
    end

    redirect_to submission_task_path(@submission, @task)
  end

  private

  def correspondence_params
    params.require(:correspondence)
          .permit(:subject, :format, :noted_at, :content)
  end

  def load_submission
    @submission = Submission.find(params[:submission_id])
  end
end

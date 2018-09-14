class Submission::OfficialNoController < InternalPagesController
  respond_to :js

  def update
    @submission = Submission.find(params[:submission_id])
    reg_no = official_no_params[:content]

    if reg_no && !RegNoValidator.valid?(reg_no, current_activity.part)
      render :error
    else
      Builders::OfficialNoBuilder.build(@submission, reg_no)
      render :update
    end
  end

  protected

  def official_no_params
    params.require(:official_no).permit(:content)
  end
end

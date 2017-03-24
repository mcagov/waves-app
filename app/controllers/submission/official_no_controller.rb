class Submission::OfficialNoController < InternalPagesController
  def update
    @submission = Submission.find(params[:submission_id])
    @official_no = OfficialNo.new(official_no_params)

    reg_no = official_no_params[:content]

    if reg_no && !RegNoValidator.valid?(reg_no)
      flash[:notice] = "That Official Number is not available"
    else
      Builders::OfficialNoBuilder.build(@submission, reg_no)
    end

    redirect_to @submission
  end

  protected

  def official_no_params
    params.require(:official_no).permit(:content)
  end
end

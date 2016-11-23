class Submission::DocumentsController < InternalPagesController
  before_action :load_submission

  def create
    @document = Document.new(document_params)
    @document.actioned_by = current_user
    @document.noteable = @submission

    flash[:notice] = "The document has been saved" if @document.save

    redirect_to submission_path(@submission)
  end

  private

  def load_submission
    @submission =
      Submission
      .in_part(current_activity.part).find(params[:submission_id])
  end

  def document_params
    params.require(:document).permit(
      :content, :noted_at, assets_attributes: [:file])
  end
end

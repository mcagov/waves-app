class Submission::DocumentsController < InternalPagesController
  before_action :load_submission

  def create
    @document = Document.new(document_params)
    @document.actioned_by = current_user
    @document.noteable = @submission

    @submission.unreferred! if @submission.can_unreferred?

    if @document.save
      flash[:notice] = "The document has been saved"
      log_work!(@submission, @document, :document_entry)
    end

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

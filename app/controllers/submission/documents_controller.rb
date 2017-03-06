class Submission::DocumentsController < InternalPagesController
  before_action :load_submission

  def create
    @document = Document.new(document_params)
    @document.actioned_by = current_user
    @document.noteable = @submission
    # fire a state machine event #unreferred if currently referred
    @submission.unreferred! if @submission.can_unreferred?

    if @document.save
      flash[:notice] = "The document has been saved"
      log_work!(@submission, @document, :document_entry)
    end

    respond_to do |format|
      format.html { redirect_to submission_path(@submission) }
      format.js do
        @modal_id = params[:modal_id]
        render "/submissions/extended/forms/documents/update"
      end
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.js { render "/submissions/extended/forms/documents/update" }
    end
  end

  private

  def load_submission
    @submission =
      Submission
      .in_part(current_activity.part).find(params[:submission_id])
  end

  def document_params
    params.require(:document).permit(
      :entity_type, :issuing_authority, :expires_at,
      :content, :noted_at, assets_attributes: [:file])
  end
end

class Submission::CarvingAndMarkingController < InternalPagesController
  before_action :load_submission

  def create
    @carving_and_marking = CarvingAndMarking.new(carving_and_marking_params)
    @carving_and_marking.submission = @submission
    @carving_and_marking.issued_by = current_user

    process_carving_and_marking if @carving_and_marking.save

    render_update_js
  end

  protected

  def carving_and_marking_params
    params.require(:carving_and_marking).permit(
      :delivery_method, :tonnage_type, :template)
  end

  def load_submission
    @submission = Submission.find(params[:submission_id])
  end

  def render_update_js
    respond_to do |format|
      @modal_id = params[:modal_id]
      @submission = Decorators::Submission.new(@submission)
      format.js do
        render "/submissions/extended/forms/carving_and_marking/update"
      end
    end
  end

  def process_carving_and_marking
    Notification::CarvingAndMarkingNote.create(
      recipient_email: @submission.applicant_email,
      recipient_name: @submission.applicant_name,
      notifiable: @carving_and_marking,
      actioned_by: current_user,
      attachments: @carving_and_marking.template)

    log_work!(@submission, @submission, :issued_carving_and_marking_note)
  end
end

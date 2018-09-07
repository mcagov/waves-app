class Submission::CarvingAndMarkingController < InternalPagesController
  before_action :load_submission
  before_action :load_task

  def create
    @carving_and_marking = CarvingAndMarking.new(carving_and_marking_params)
    @carving_and_marking.submission = @submission
    @carving_and_marking.actioned_by = current_user

    if @carving_and_marking.save
      process_carving_and_marking
      log_work!(@task, @task, :carving_and_marking_issued)
    end

    render_update_js
  end

  def update_state
    if @submission.carving_and_marking_received_at
      @submission.update_attribute(
        :carving_and_marking_received_at, nil)
    else
      @submission.update_attribute(
        :carving_and_marking_received_at, Time.zone.now)
    end

    render_update_js
  end

  protected

  def carving_and_marking_params
    params.require(:carving_and_marking).permit(:delivery_method, :template)
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
    Builders::CarvingAndMarkingBuilder.build(@carving_and_marking)
  end
end

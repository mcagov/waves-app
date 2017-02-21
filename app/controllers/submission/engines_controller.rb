class Submission::EnginesController < InternalPagesController
  before_action :load_submission

  def create
    @engine = Engine.new(engine_params)
    @engine.parent = @submission
    @engine.save

    respond_to do |format|
      @modal_id = params[:modal_id]
      format.js { render "/submissions/extended/forms/engines/update" }
    end
  end

  private

  def load_submission
    @submission =
      Submission
      .in_part(current_activity.part).find(params[:submission_id])
  end

  def engine_params
    params.require(:engine).permit(
      :engine_type, :make, :model, :cylinders, :derating,
      :rpm, :mcep_per_engine, :mcep_after_derating, :quantity)
  end
end

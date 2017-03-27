class Submission::CharterersController < InternalPagesController
  before_action :load_submission

  def create
    @charterer = Charterer.new(charterer_params)
    @charterer.parent = @submission
    @charterer.save

    respond_with_update
  end

  def update
    @charterer = Charterer.find(params[:id])
    @charterer.update_attributes(charterer_params)

    respond_with_update
  end

  def destroy
    @charterer = Charterer.find(params[:id])
    @charterer.destroy

    respond_with_update
  end

  private

  def load_submission
    @submission =
      Submission
      .in_part(current_activity.part).find(params[:submission_id])
  end

  def charterer_params
    params.require(:charterer).permit(
      :reference_number, :start_date, :end_date,
      charter_parties_attributes: [
        :id, :name, :address, :contact_details,
        :declaration_signed, :_destroy])
  end

  def respond_with_update
    respond_to do |format|
      @modal_id = params[:modal_id]
      format.js { render "/submissions/extended/forms/charterers/update" }
    end
  end
end

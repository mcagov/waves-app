class Submission::Charterers::CharterPartiesController < InternalPagesController
  before_action :load_submission, :load_charterer

  def create
    @charter_party = @charterer.charter_parties.create(charter_party_params)

    respond_with_update
  end

  def update
    @charter_party = @charterer.charter_parties.find(params[:id])
    @charter_party.update_attributes(charter_party_params)

    respond_with_update
  end

  def destroy
    @charter_party = @charterer.charter_parties.find(params[:id])
    @charter_party.destroy

    respond_with_update
  end

  private

  def load_charterer
    @charterer = @submission.charterers.find(params[:charterer_id])
  end

  def charter_party_params
    params.require(:charter_party).permit(
      CharterParty.attribute_names, :declaration_signed)
  end

  def respond_with_update
    respond_to do |format|
      @modal_id = params[:modal_id]
      format.js { render "/submissions/extended/forms/charterers/update" }
    end
  end
end

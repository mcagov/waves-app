class Submission::BeneficialOwnersController < InternalPagesController
  before_action :load_submission

  def create
    @beneficial_owner = Submission::BeneficialOwner.new(beneficial_owner_params)
    @beneficial_owner.parent = @submission
    @beneficial_owner.save!

    respond_with_update
  end

  def update
    @beneficial_owner = Submission::BeneficialOwner.find(params[:id])
    @beneficial_owner.update_attributes(beneficial_owner_params)

    respond_with_update
  end

  def destroy
    @beneficial_owner = Submission::BeneficialOwner.find(params[:id])
    @beneficial_owner.destroy

    respond_with_update
  end

  private

  def load_submission
    @submission =
      Submission
      .in_part(current_activity.part).find(params[:submission_id])
  end

  def beneficial_owner_params
    params.require(:submission_beneficial_owner).permit(
      :name, :email, :phone_number, :imo_number, :eligibility_status,
      :nationality, :address_1, :address_2, :address_3, :town, :postcode)
  end

  def respond_with_update
    respond_to do |format|
      @modal_id = params[:modal_id]
      format.js do
        render "/submissions/extended/forms/beneficial_owners/update"
      end
    end
  end
end

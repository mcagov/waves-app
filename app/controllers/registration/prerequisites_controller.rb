class Registration::PrerequisitesController < Registration::BaseController
  def show
    @prerequisite = Prerequisite.new
  end

  def update
    @prerequisite = Prerequisite.new(prerequisite_params)

    if @prerequisite.valid?
      store_in_session(:prerequisites, prerequisite_params)
      return redirect_to controller: :vessel_info, action: :show
    end

    render :show
  end

  private

  def prerequisite_params
    params.require(:prerequisite).permit(
      :not_registered_before_on_ssr,
      :not_registered_under_part_1,
      :not_owned_by_company,
      :not_commercial_fishing_or_submersible,
      :owners_are_uk_residents,
      :owners_are_eligible_to_register,
      :not_registered_on_foreign_registry
    )
  end
end

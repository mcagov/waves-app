class RegistrationProcessController < ApplicationController
  def prerequisites
    case request.method
    when "GET"
      @prerequisite = Prerequisite.new
    else
      @prerequisite = Prerequisite.new(prerequisites_params)
      if @prerequisite.valid?
        store_in_session(:prerequisites, prerequisites_params)
        redirect_to action: :vessel_info
      end
    end
  end

  def vessel_info
    byebug
  end

  private

  def store_in_session
  end

  def prerequisites_params
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

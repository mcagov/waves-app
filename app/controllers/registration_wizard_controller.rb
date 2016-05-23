class RegistrationWizardController < ApplicationController
  include Wicked::Wizard::Translated

  steps :prerequisites, :vessel_info, :owner_info

  def show
    case step
    when I18n.t("wicked.prerequisites")
      @registration = Registration.new
    when I18n.t("wicked.vessel_info")
      @registration = Registration.find(params[:registration_id])
    end

    render_wizard
  end

  def update
    case step
    when I18n.t("wicked.prerequisites")
      @registration = Registration.create(
        prerequisite_params.merge(
          status: :initiated,
          browser: request.env["HTTP_USER_AGENT"] || "Unknown"
        )
      )
    when I18n.t("wicked.vessel_info")
      @registration = Registration.find(params[:registration][:id])
      @registration.update(
        vessel_info_params.merge(status: :vessel_info_added)
      )
    end

    if @registration.valid?
      redirect_to next_wizard_path(registration_id: @registration.id)
    else
      render_wizard @registration
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  def vessel_info_params
    params.require(:registration).permit(
      :id,
      vessels_attributes: [
        :name,
        :hin,
        :make_and_model,
        :length_in_centimeters,
        :number_of_hulls,
        :vessel_type_id,
        :mmsi_number,
        :radio_call_sign,
      ]
    )
  end
  # rubocop:enable Metrics/MethodLength

  def prerequisite_params
    params.require(:registration).permit(
      :not_registered_before_on_ssr,
      :not_registered_under_part_1,
      :owners_are_uk_residents,
      :user_eligible_to_register
    )
  end
end

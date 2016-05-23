class RegistrationWizardController < ApplicationController
  include Wicked::Wizard::Translated

  steps :prerequisites, :vessel_info, :owner_info, :declaration, :payment

  def show
    case step_name
    when prerequisites_step_name
      @registration = Registration.new
    when vessel_info_step_name,
         owner_info_step_name,
         declaration_step_name
      @registration = Registration.find(params[:registration_id])
    end

    render_wizard
  end

  def update
    case step_name
    when prerequisites_step_name
      @registration = Registration.create(
        prerequisite_params.merge(
          status: :initiated,
          browser: request.env["HTTP_USER_AGENT"] || "Unknown"
        )
      )
    when vessel_info_step_name
      @registration = Registration.find(params[:registration][:id])
      @registration.update(
        vessel_info_params.merge(status: :vessel_info_added)
      )
    when declaration_step_name
      @registration = Registration.find(params[:registration][:id])
      @registration.update(
        declaration_params.merge(status: :declaration_accepted)
      )
    end

    if @registration.valid?
      redirect_to next_wizard_path(registration_id: @registration.id)
    else
      render_wizard @registration
    end
  end

  private

  def declaration_params
    params.require(:registration).permit(
      :id,
      :eligible_under_regulation_89,
      :eligible_under_regulation_90,
      :understands_false_statement_is_offence
    )
  end

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

  def prerequisites_step_name
    I18n.t("wicked.prerequisites")
  end

  def vessel_info_step_name
    I18n.t("wicked.vessel_info")
  end

  def owner_info_step_name
    I18n.t("wicked.owner_info")
  end

  def declaration_step_name
    I18n.t("wicked.declaration")
  end

  def payment_step_name
    I18n.t("wicked.payment")
  end

  def step_name
    step
  end
end

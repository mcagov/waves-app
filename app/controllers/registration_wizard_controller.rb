class RegistrationWizardController < ApplicationController
  include Wicked::Wizard::Translated

  steps :prerequisites, :vessel_info, :owner_info, :declaration, :payment

  def show
    case step_name
    when prerequisites_step_name
      @registration = Registration.new
    when vessel_info_step_name
      @registration = Registration.find(params[:registration_id])
      @vessels = [Vessel.new]
    when owner_info_step_name,
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
          status: "initiated",
          browser: request.env["HTTP_USER_AGENT"] || "Unknown"
        )
      )
    when vessel_info_step_name
      @registration = Registration.find(params[:registration][:id])
      @registration.update(
        vessel_info_params.merge(status: "vessel_info_added")
      )
    when declaration_step_name
      @registration = Registration.find(params[:registration][:id])
      @registration.update(
        declaration_params.merge(status: "declaration_accepted")
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
    assign_hin_parameter
    assign_length_in_centimeters_parameter

    params.require(:registration).permit(
      :id,
      vessels_attributes: [
        :name,
        :hin,
        :make_and_model,
        :length_in_centimeters,
        :number_of_hulls,
        :vessel_type_id,
        :vessel_type_other,
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
      :not_owned_by_company,
      :not_commercial_fishing_or_submersible,
      :owners_are_uk_residents,
      :owners_are_eligible_to_register,
      :not_registered_on_foreign_registry
    )
  end

  def declaration_params
    params.require(:registration).permit(
      :id,
      :eligible_under_regulation_89,
      :eligible_under_regulation_90,
      :understands_false_statement_is_offence
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

  def assign_hin_parameter
    return unless hin_parameter_is_present?

    hin_parameters = params.delete(:hin)
    hin = "#{hin_parameters["prefix"]}-#{hin_parameters["suffix"]}".upcase

    params[:registration][:vessels_attributes]["0"].merge!(hin: hin)
  end

  def hin_parameter_is_present?
    params[:hin]["prefix"].present? || params[:hin]["suffix"].present?
  end

  def assign_length_in_centimeters_parameter
    return unless length_in_centimeters_parameter_is_present?

    length_parameters = params.delete(:length_in_centimeters)
    length_in_centimetres = length_parameters["m"].to_i * 100 + length_parameters["cm"].to_i

    params[:registration][:vessels_attributes]["0"].merge!(length_in_centimeters: length_in_centimetres)
  end

  def length_in_centimeters_parameter_is_present?
    params[:length_in_centimeters]["m"].present? || params[:length_in_centimeters]["cm"].present?
  end
end

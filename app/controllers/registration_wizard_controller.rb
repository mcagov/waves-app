class RegistrationWizardController < ApplicationController
  include Wicked::Wizard::Translated

  layout "public"

  steps :prerequisites, :vessel_info, :owner_info, :declaration, :payment

  def show
    case step_name
    when prerequisites_step_name
      @registration = Registration.new
    when vessel_info_step_name
      @registration = Registration.find(params[:registration_id])
      @registration.build_vessel
    when owner_info_step_name
      @registration = Registration.find(params[:registration_id])
      @owner = Owner.new
    when declaration_step_name
      @registration = Registration.find(params[:registration_id])
    end

    render_wizard
  end

  def update
    case step_name
    when prerequisites_step_name
      @registration = Registration.create(
        prerequisite_params.merge(
          browser: request.env["HTTP_USER_AGENT"] || "Unknown"
        )
      )

      if @registration.valid?
        redirect_to next_wizard_path(registration_id: @registration.id)
      else
        render_wizard @registration
      end
    when vessel_info_step_name
      @registration = Registration.find(params[:registration][:id])
      @registration.update(vessel_info_params)
      @registration.trigger(:added_vessel_info)

      if @registration.valid?
        redirect_to next_wizard_path(registration_id: @registration.id)
      else
        render_wizard @registration
      end
    when owner_info_step_name
      @registration = Registration.find(params[:registration_id])
      @owner = Owner.new(owner_info_params)

      if @owner.valid?
        @owner.save
        @registration.vessel.owners << @owner
        @registration.trigger(:added_owner_info)

        redirect_to next_wizard_path(registration_id: @registration.id)
      else
        render_step owner_info_step_name
      end
    when declaration_step_name
      @registration = Registration.find(params[:registration][:id])
      @registration.update(declaration_params)
      @registration.trigger(:accepted_declaration)

      if @registration.valid?
        redirect_to next_wizard_path(registration_id: @registration.id)
      else
        render_wizard @registration
      end
    end
  end

  private

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

  # rubocop:disable Metrics/MethodLength
  def vessel_info_params
    assign_vessel_param(:hin)
    assign_vessel_param(:length_in_centimeters)

    params.require(:registration).permit(
      :id,
      vessel_attributes: [
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

  def owner_info_params
    if params[:owner][:title_other].present?
      params[:owner][:title] = params[:owner][:title_other]
    end
    params[:owner].delete(:title_other)

    params.require(:owner).permit(
      :title,
      :first_name,
      :last_name,
      :nationality,
      :email,
      :mobile_number,
      :phone_number
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

  def assign_vessel_param(parameter)
    return unless vessel_param_is_present?(parameter)

    parameter_hash = params.delete(parameter)
    value =
      case parameter
      when :hin
        "#{parameter_hash["prefix"]}-#{parameter_hash["suffix"]}".upcase
      when :length_in_centimeters
        parameter_hash["m"].to_i * 100 + parameter_hash["cm"].to_i
      end

    params[:registration][:vessel_attributes].merge!(parameter => value)
  end

  def vessel_param_is_present?(parameter)
    params[parameter].values.any? { |value| value.present? }
  end
end

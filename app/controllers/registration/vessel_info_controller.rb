class Registration::VesselInfoController < Registration::BaseController
  def show
    @vessel_info = VesselInfo.new
  end

  def update
    @vessel_info = VesselInfo.new(vessel_info_params)

    validate_mmsi_for(@vessel_info)

    if @vessel_info.valid?
      store_in_session(:vessel_info, vessel_info_params)
      return redirect_to controller: :owner_info, action: :show
    end

    render :show
  end

  private

  def vessel_info_params
    modify_param(:hin)
    modify_param(:length_in_centimeters)

    params.require(:vessel_info).permit(
      :name,
      :hin,
      :make_and_model,
      :length_in_centimeters,
      :number_of_hulls,
      :vessel_type_id,
      :vessel_type_other,
      :mmsi_number,
      :radio_call_sign
    )
  end

  def modify_param(parameter)
    return unless params.key?(parameter)

    parameter_hash = params.delete(parameter)
    value =
      case parameter
      when :hin
        if parameter_hash['prefix'].present? && parameter_hash['suffix'].present?
          "#{parameter_hash['prefix']}-#{parameter_hash['suffix']}".upcase
        else
          nil
        end
      when :length_in_centimeters
        parameter_hash["m"].to_i * 100 + parameter_hash["cm"].to_i
      end

    params[:vessel_info].merge!(parameter => value)
  end

  def validate_mmsi_for(vessel_info)
    if Vessel.find_by_mmsi_number(vessel_info.mmsi_number)
      message = I18n.t(
        "activemodel.errors.models.vessel_info.attributes.mmsi_number.taken"
      )
      vessel_info.errors.add(:mmsi_number, message)
    end
  end
end

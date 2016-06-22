class Registration::VesselInfoController < Registration::BaseController
  def show
    @vessel_info = VesselInfo.new
  end

  def update
    @vessel_info = VesselInfo.new(vessel_info_params)

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
        "#{parameter_hash['prefix']}-#{parameter_hash['suffix']}".upcase
      when :length_in_centimeters
        parameter_hash["m"].to_i * 100 + parameter_hash["cm"].to_i
      end

    params[:vessel_info].merge!(parameter => value)
  end
end

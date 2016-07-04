class VesselInfo
  include ActiveModel::Model
  include VesselValidations

  attr_accessor(
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

  def type
    if vessel_type_other.present?
      vessel_type_other
    else
      VesselType.find(vessel_type_id).designation.capitalize
    end
  end

  def length_in_meters
    (length_in_centimeters / 100.0).round(2)
  end

  private

  def hin_must_begin_with_a_valid_country_code
    return if hin.blank? || ISO3166::Data.codes.include?(hin[0..1])

    message = I18n.t("activerecord.errors.models.vessel.attributes.hin.invalid")
    errors.add(:hin, message)
  end
end

class VesselInfo
  include ActiveModel::Model

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

  validates_presence_of :name,
                        :hin,
                        :length_in_centimeters,
                        :number_of_hulls,
                        :mmsi_number,
                        :radio_call_sign

  validates_presence_of :vessel_type_id,
                        unless: proc { |vi| vi.vessel_type_other.present? }

  validates_presence_of :vessel_type_other,
                        unless: proc { |vi| vi.vessel_type_id.present? }

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
end

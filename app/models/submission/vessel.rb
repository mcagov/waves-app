class Submission::Vessel
  include VirtualModel

  attr_accessor(
    :name,
    :hin,
    :make_and_model,
    :length_in_meters,
    :number_of_hulls,
    :mmsi_number,
    :radio_call_sign,
    :alt_name_1,
    :alt_name_2,
    :alt_name_3,
    :length_in_meters,
    :vessel_type,
    :vessel_type_other
  )

  def alt_names
    [alt_name_1, alt_name_2, alt_name_3].compact
  end
end

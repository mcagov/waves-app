class Submission::Vessel < Vessel
  attr_accessor(
    :alt_name_1,
    :alt_name_2,
    :alt_name_3,
    :length_in_meters,
    :vessel_type,
    :vessel_type_other
  )

  def initialize(params={})
    params.reject!{|param| !self.respond_to?(param)}
    super
  end

  def type_of_vessel
    if vessel_type_other.present?
      vessel_type_other
    else
      vessel_type
    end
  end
end

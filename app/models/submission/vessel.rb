class Submission::Vessel < Vessel
  attr_accessor(
    :alt_name_1,
    :alt_name_2,
    :alt_name_3,
    :length_in_meters,
    :vessel_type,
    :owners
  )

  def initialize(params={})
    params.reject!{|param| !self.respond_to?(param)}
    super
  end
end

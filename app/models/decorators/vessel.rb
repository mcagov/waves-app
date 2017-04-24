class Decorators::Vessel < SimpleDelegator
  def initialize(vessel)
    @vessel = vessel
    super
  end

  def formatted_propulsion_system
    ret =
      propulsion_system.map do |key|
        WavesUtilities::PropulsionSystem.new(key).name
      end
    ret.reject(&:empty?).join(", ")
  end

  def vessel_type_description
    vessel_type.present? ? vessel_type : vessel_category
  end

  def imo_number_or_hin
    imo_number.present? ? imo_number : hin
  end
end

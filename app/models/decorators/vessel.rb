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
end

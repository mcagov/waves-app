class RegistrarTools
  def initialize(registered_vessel)
    @registered_vessel = registered_vessel
  end

  def manual_override_service
    @manual_override_service ||= Service.find_by(name: "Manual Override")
  end
end

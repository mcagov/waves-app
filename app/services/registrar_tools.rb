class RegistrarTools
  def initialize(registered_vessel)
    @registered_vessel = registered_vessel
  end

  def service(key)
    service_name = ApplicationType.new(key).description
    Service.find_by(name: service_name) if service_name
  end
end

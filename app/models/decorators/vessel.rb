class Decorators::Vessel < SimpleDelegator
  def initialize(vessel)
    @vessel = vessel
    super
  end

  def vessel_type_description
    vessel_type.present? ? vessel_type : vessel_category
  end

  def imo_number_or_hin
    imo_number.present? ? imo_number : hin
  end

  def engine_description
    engines.map(&:make_and_model).join("; ")
  end

  def engine_derating_description
    engines.map(&:derating).reject(&:blank?).join("; ")
  end

  def pln
    "#{port_code}#{port_no}"
  end
end

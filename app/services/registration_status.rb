class RegistrationStatus
  def initialize(vessel)
    @vessel = vessel
    @key = build_key
  end

  def build_key
    return :frozen if @vessel.frozen_at.present?
    return :pending unless @vessel.registrations.first
    return :closed if @vessel.registrations.first.try(:closed_at?)
    return :expired if Time.now.to_i > @vessel.registered_until.to_i
    :registered
  end

  def to_s
    case @key
    when :frozen then "Frozen"
    when :pending then "In Progress"
    when :closed then "Registration Closed"
    when :expired then "Registration Expired"
    when :registered then registered_description
    end
  end

  def ui_color
    case @key
    when :frozen then "danger"
    when :pending then "info"
    when :closed then "warning"
    when :expired then "default"
    when :registered then "success"
    end
  end

  def ==(other)
    @key == other
  end

  def !=(other)
    @key != other
  end

  def to_json
    @key
  end

  private

  def registered_description
    if @vessel.registrations.first.try(:provisional?)
      "Registered Provisionally"
    else
      "Registered"
    end
  end
end

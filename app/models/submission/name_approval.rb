class Submission::NameApproval
  include ActiveModel::Model

  attr_accessor(
    :part, :name, :port_code, :port_no, :registration_type,
    :net_tonnage, :gross_tonnage)

  validates :name, presence: true
  validates :port_code, presence: true
  validates :port_no, numericality: { only_integer: true, allow_nil: true }

  validate :unique_name_in_port
  validate :unique_port_no_in_port

  def registration_types
    WavesUtilities::RegistrationType.all.map do |registration_type|
      [registration_type.to_s.humanize, registration_type]
    end
  end

  def ports
    WavesUtilities::Port.all(part)
  end

  def port_name
    ports.find { |port| port[1] == port_code }.first
  end

  def unique_name_in_port
    errors.add(:name, "is not available in #{port_name}") if name_in_use?
  end

  def unique_port_no_in_port
    return unless port_no
    errors.add(:port_no, "is not available in #{port_name}") if port_no_in_use?
  end

  private

  def name_in_use?
    Register::Vessel
      .in_part(part)
      .where(name: name)
      .where(port_code: port_code)
      .where("name_approved_until is null or name_approved_until > now()")
      .exists?
  end

  def port_no_in_use?
    Register::Vessel
      .in_part(part)
      .where(port_no: port_no)
      .where(port_code: port_code)
      .where("name_approved_until is null or name_approved_until > now()")
      .exists?
  end
end

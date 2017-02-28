class Submission::NameApproval
  include ActiveModel::Model

  attr_accessor :part, :name, :port_code, :port_no, :registration_type

  validates :name, presence: true
  validates :port_code, presence: true
  validates :port_no, allow_blank: true, numericality: { only_integer: true }

  validate :unique_name_in_port
  validate :unique_port_no_in_port

  def port_name
    WavesUtilities::Port.new(port_code).name
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

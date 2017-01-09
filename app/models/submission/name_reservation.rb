class Submission::NameReservation < ApplicationRecord
  self.table_name = "vessels"

  validates :name, presence: true
  validates :port_code, presence: true
  validates :port_no, presence: true

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

  def unique_name_in_port
    errors.add(:name, "is not available") if name_in_use?
  end

  def unique_port_no_in_port
    errors.add(:port_no, "is not available") if port_no_in_use?
  end

  private

  def name_in_use?
    Register::Vessel
      .where(name: name)
      .where(port_code: port_code)
      .where("name_reserved_until is null or name_reserved_until > now()")
      .exists?
  end

  def port_no_in_use?
    Register::Vessel
      .where(port_no: port_no)
      .where(port_code: port_code)
      .where("name_reserved_until is null or name_reserved_until > now()")
      .exists?
  end
end

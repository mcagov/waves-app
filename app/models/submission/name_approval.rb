class Submission::NameApproval < ApplicationRecord
  self.table_name = "name_approvals"

  belongs_to :submission

  validates :submission_id, presence: true
  validates :name, presence: true
  validates :port_code, presence: true
  validates :port_no, allow_blank: true, numericality: { only_integer: true }

  validate :unique_name_in_port
  validate :unique_port_no_in_port

  scope :in_part, ->(part) { where(part: part.to_sym) }

  scope :active, (lambda do
    where("approved_until is null or approved_until > now()")
      .where("cancelled_at is null")
  end)

  def port_name
    WavesUtilities::Port.new(port_code).name
  end

  def unique_name_in_port
    return unless name_changed?

    unless VesselNameValidator.valid?(part, name, port_code, registration_type)
      errors.add(:name, "is not available in #{port_name}")
    end
  end

  def unique_port_no_in_port
    return if port_no.blank?
    return unless port_no_changed?

    unless VesselPortNoValidator.valid?(port_no, port_code)
      errors.add(:port_no, "is not available in #{port_name}")
    end
  end

  private

  def submission_vessel
    @submission_vessel ||= submission.vessel
  end

  def port_code_changed?
    submission_vessel.port_code != port_code
  end

  def name_changed?
    (submission_vessel.name != name) || port_code_changed?
  end

  def port_no_changed?
    (submission_vessel.port_no != port_no) || port_code_changed?
  end
end

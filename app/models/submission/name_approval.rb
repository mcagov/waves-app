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

  def port_name
    WavesUtilities::Port.new(port_code).name
  end

  def unique_name_in_port
    unless VesselNameValidator.valid?(part, name, port_code)
      errors.add(:name, "is not available in #{port_name}")
    end
  end

  def unique_port_no_in_port
    unless VesselPortNoValidator.valid?(part, port_no, port_code)
      errors.add(:port_no, "is not available in #{port_name}")
    end
  end

  private

  def name_in_use?
    VesselNameValidator.new(self).name_in_use?
  end

  def port_no_in_use?
    VesselNameValidator.new(self).port_no_in_use?
  end

  def init_defaults
    self.approved_until ||= 90.days.from_now
    self.port_no ||= SequenceNumber::Generator.port_no!(port_code)
    store_submission_vessel if submission
  end

  def store_submission_vessel
    vessel = submission.vessel
    vessel.name = name
    vessel.port_no = port_no
    vessel.port_code = port_code
    vessel.registration_type = registration_type
    submission.vessel = vessel
    submission.save
  end
end

class Submission::NameApproval < ApplicationRecord
  self.table_name = "name_approvals"

  belongs_to :submission

  validates :name, presence: true
  validates :port_code, presence: true
  validates :port_no, allow_blank: true, numericality: { only_integer: true }

  validate :unique_name_in_port
  validate :unique_port_no_in_port

  include ActiveModel::Transitions
  state_machine do
    state :open, enter: :init_defaults
  end

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
    VesselNameValidator.new(self).name_in_use?
  end

  def port_no_in_use?
    VesselNameValidator.new(self).port_no_in_use?
  end

  def init_defaults
    self.approved_until = 90.days.from_now
    self.port_no ||= SequenceNumber::Generator.port_no!(port_code)

    vessel = submission.vessel
    vessel.name = name
    vessel.port_no = port_no
    vessel.port_code = port_code
    vessel.registration_type = registration_type
    submission.vessel = vessel
    submission.save
  end
end

class Submission::NameApproval < ApplicationRecord
  self.table_name = "name_approvals"

  belongs_to :submission

  validates :submission_id, presence: true
  validates :name, presence: true
  validates :port_code, presence: true, unless: :part_1?
  validates :port_no, allow_blank: true, numericality: { only_integer: true }

  validate :unique_name_in_port
  validate :unique_port_no_in_port

  scope :in_part, ->(part) { where(part: part.to_sym) }
  scope :active, -> { where(cancelled_at: nil) }

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
    return true if new_record?
    return true if submission_vessel.name != name
    return port_code_changed? unless Policies::Definitions.part_1?(self)
    false
  end

  def port_no_changed?
    return true if new_record?
    (submission_vessel.port_no != port_no) || port_code_changed?
  end

  def part_1?
    part.to_sym == :part_1
  end
end

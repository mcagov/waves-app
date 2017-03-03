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
end

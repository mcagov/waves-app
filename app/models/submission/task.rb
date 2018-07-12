class Submission::Task < ApplicationRecord
  belongs_to :service
  delegate :to_sym, to: :service

  belongs_to :submission
  delegate :received_at, to: :submission
  delegate :service_level, to: :submission

  protokoll :submission_ref_counter, scope_by: :submission_id, pattern: "#"

  before_create :assign_target_date

  validates :price, presence: true

  def ref_no
    "#{submission.ref_no}/#{submission_ref_counter}"
  end

  private

  def assign_target_date
    self.target_date =
      TargetDate.new(
        (received_at || Date.current),
        service_level,
        service
      ).calculate
  end
end

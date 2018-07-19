class Submission::Task < ApplicationRecord
  belongs_to :service
  delegate :to_sym, to: :service

  belongs_to :submission
  delegate :received_at, to: :submission

  validates :price, presence: true
  validates :service_level, presence: true

  enum service_level: ServiceLevel::SERVICE_LEVEL_TYPES.map(&:last)

  protokoll :submission_ref_counter, scope_by: :submission_id, pattern: "#"

  before_create :assign_start_date

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :initialising
    state :unassigned

    event :confirm do
      transitions to: :unassigned, from: :initialising,
                  on_transition: :assign_target_date,
                  guard: :initialising?
    end
  end

  def ref_no
    "#{submission.ref_no}/#{submission_ref_counter}"
  end

  private

  def assign_start_date
    self.start_date = submission.received_at
  end

  def assign_target_date
    update_attribute(
      :target_date,
      TargetDate.new(
        (start_date || Date.current),
        service_level,
        service).calculate)
  end
end

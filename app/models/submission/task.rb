class Submission::Task < ApplicationRecord
  belongs_to :service
  delegate :to_sym, to: :service

  belongs_to :submission
  delegate :part, to: :submission
  delegate :received_at, to: :submission

  validate :service_level_validations
  enum service_level: ServiceLevel::SERVICE_LEVEL_TYPES.map(&:last)

  protokoll :submission_ref_counter, scope_by: :submission_id, pattern: "#"

  before_save :set_defaults

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :initialising
    state :unassigned

    event :confirm do
      transitions to: :unassigned, from: :initialising,
                  guard: :initialising?
    end
  end

  def ref_no
    "#{submission.ref_no}/#{submission_ref_counter}"
  end

  private

  def set_defaults
    self.start_date ||= submission.received_at || Date.current
    self.price = service.price_for(part, service_level.to_sym)
    self.target_date = TargetDate.for_task(self) unless initialising?
  end

  def service_level_validations
    if service_level.blank?
      errors.add(:service_level, "is required")
    elsif service_level.to_sym == :premium && !service.supports_premium?(part)
      errors.add(:service_level, "is not allowed")
    end
  end
end

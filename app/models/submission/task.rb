class Submission::Task < ApplicationRecord
  belongs_to :service

  belongs_to :submission
  delegate :part, to: :submission
  delegate :received_at, to: :submission

  belongs_to :claimant, required: false, class_name: "User"

  has_many :work_logs
  has_many :staff_performance_logs

  validate :service_level_validations
  enum service_level: ServiceLevel::SERVICE_LEVEL_TYPES.map(&:last)

  validates :price, presence: true

  before_save :set_defaults

  scope :in_part, (lambda do |part|
    joins(:submission).where("submissions.part = ?", part) if part
  end)

  scope :confirmed, -> { where.not(state: [:initialising]) }
  scope :active, -> { where(state: [:unclaimed, :claimed, :referred]) }

  scope :claimed_by, (lambda do |claimant|
    where(claimant: claimant).where(state: :claimed)
  end)

  scope :service_level, (lambda do |service_level|
    where(service_level: service_level) unless service_level.blank?
  end)

  scope :registration_type, (lambda do |registration_type|
    includes(:submission).where(
      "(submissions.changeset#>>'{vessel_info, registration_type}') = ?",
      registration_type) unless registration_type.blank?
  end)

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :initialising
    state :unclaimed
    state :claimed
    state :referred
    state :completed
    state :cancelled

    event :confirm do
      transitions to: :unclaimed, from: :initialising,
                  guard: :initialising?,
                  on_transition: :set_submission_ref_counter
    end

    event :claim do
      transitions to: :claimed,
                  from: [:unclaimed, :cancelled],
                  on_transition: :add_claimant
    end

    event :refer do
      transitions to: :referred, from: :claimed,
                  on_transition: :remove_claimant
    end

    event :unclaim do
      transitions to: :unclaimed, from: :claimed,
                  on_transition: :remove_claimant
    end

    event :complete, timestamp: :completed_at do
      transitions to: :completed, from: :claimed,
                  on_transition: :process_task
    end

    event :cancel do
      transitions to: :cancelled, from: :claimed,
                  on_transition: [:remove_claimant]
    end

    event :claim_referral do
      transitions to: :claimed, from: :referred,
                  on_transition: [:add_claimant, :reset_dates]
    end

    event :unrefer do
      transitions to: :unclaimed, from: :referred,
                  on_transition: [:reset_dates]
    end
  end

  attr_accessor(
    :notification_attachments,
    :registration_starts_at,
    :registration_ends_at,
    :closure_at,
    :closure_reason,
    :supporting_info
  )

  def ref_no
    return "" unless submission_ref_counter
    "#{submission.ref_no}/#{submission_ref_counter}"
  end

  def claimed_by?(user)
    claimed? && claimant == user
  end

  def process_task(approval_params)
    ApplicationProcessor.run(self, approval_params)
  end

  def price_in_pounds
    (price / 100).to_i
  end

  def price_in_pounds=(input)
    self.price = input.to_i * 100
  end

  def reset_dates(*)
    self.start_date = Date.current
    self.target_date = TargetDate.for_task(self)
  end

  private

  def set_defaults
    self.start_date ||= submission.received_at || Date.current
    self.target_date = TargetDate.for_task(self) unless initialising?
  end

  def set_submission_ref_counter
    self.submission_ref_counter = RefCounter.next(self)
  end

  def service_level_validations
    if service_level.blank?
      errors.add(:service_level, "is required")
    elsif service_level.to_sym == :premium && !service.supports_premium?(part)
      errors.add(:service_level, "is not allowed")
    end
  end

  def add_claimant(user)
    update_attribute(:claimant, user)
  end

  def remove_claimant
    update_attribute(:claimant, nil)
  end
end

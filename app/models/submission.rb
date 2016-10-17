# rubocop:disable Metrics/ClassLength
class Submission < ApplicationRecord
  has_paper_trail only: [:state]

  include Submission::Helpers
  include Submission::Associations
  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :incomplete, enter: :init_new_submission
    state :unassigned
    state :assigned
    state :referred
    state :printing
    state :completed
    state :rejected
    state :referred
    state :cancelled

    event :paid do
      transitions to: :unassigned, from: :incomplete,
                  on_transition: :init_processing_dates,
                  guard: :unassignable?
    end

    event :declared do
      transitions to: :unassigned, from: :incomplete,
                  on_transition: :init_processing_dates,
                  guard: :unassignable?
    end

    event :claimed do
      transitions to: :assigned,
                  from: [:unassigned, :rejected, :cancelled],
                  on_transition: :add_claimant
    end

    event :unreferred do
      transitions to: :unassigned, from: :referred,
                  on_transition: :init_processing_dates
    end

    event :unclaimed do
      transitions to: :unassigned, from: :assigned,
                  on_transition: :remove_claimant
    end

    event :approved do
      transitions to: :printing, from: :assigned,
                  on_transition: :process_application
    end

    event :printed do
      transitions to: :completed, from: :printing,
                  guard: :print_jobs_completed?
    end

    event :cancelled do
      transitions to: :cancelled, from: :assigned,
                  on_transition: :remove_claimant
    end

    event :rejected do
      transitions to: :rejected, from: :assigned,
                  on_transition: :remove_claimant
    end

    event :referred do
      transitions to: :referred, from: :assigned,
                  on_transition: :remove_claimant
    end

    def event_fired(_current_state, _new_state, event)
      self.paper_trail_event = event.name
    end
  end

  validates :part, presence: true
  validates :ref_no, presence: true

  scope :referred_until_expired, lambda {
    where("date(referred_until) <= ?", Date.today)
  }

  def init_new_submission
    Builders::SubmissionBuilder.create(self)
  end

  def init_processing_dates
    Builders::ProcessingDatesBuilder.create(self, payment.amount)
  end

  def owners
    declarations.map(&:owner)
  end

  def vessel
    @vessel ||= Submission::Vessel.new(user_input[:vessel_info])
  end

  def vessel=(vessel_params)
    changeset[:vessel_info] = vessel_params
  end

  def delivery_address
    @delivery_address ||=
      Submission::DeliveryAddress.new(user_input[:delivery_address] || {})
  end

  def delivery_address=(delivery_address_params)
    changeset[:delivery_address] = delivery_address_params
  end

  def correspondent
    declarations.first.owner if declarations
  end

  def correspondent_email
    correspondent.email if correspondent
  end

  def source
    "Online"
  end

  def job_type
    "New Registration"
  end

  def user_input
    changeset.blank? ? {} : changeset.deep_symbolize_keys!
  end
end

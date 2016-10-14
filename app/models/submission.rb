class Submission < ApplicationRecord
  has_paper_trail only: [:state]

  include Submission::Attributes
  include Submission::Helpers

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
  end

  belongs_to :delivery_address, class_name: "Address", required: false
  belongs_to :claimant, class_name: "User", required: false

  has_many :payments
  def payment
    payments.first
  end

  has_many :declarations, -> { order("created_at asc") }

  has_many :notifications, as: :notifiable
  has_many :correspondences, as: :noteable

  has_one :cancellation, -> { order("created_at desc").limit(1) },
          as: :notifiable,
          class_name: "Notification::Cancellation"

  has_one :rejection, -> { order("created_at desc").limit(1) },
          as: :notifiable,
          class_name: "Notification::Rejection"

  has_one :referral, -> { order("created_at desc").limit(1) },
          as: :notifiable,
          class_name: "Notification::Referral"

  has_one :application_receipt, -> { order("created_at desc").limit(1) },
          as: :notifiable,
          class_name: "Notification::ApplicationReceipt"

  has_one :registration
  has_one :registered_vessel, through: :registration, source: :vessel

  scope :assigned_to, -> (claimant) { where(claimant: claimant) }

  scope :referred_until_expired, lambda {
    where("date(referred_until) <= ?", Date.today)
  }

  validates :part, presence: true
  validates :ref_no, presence: true
end

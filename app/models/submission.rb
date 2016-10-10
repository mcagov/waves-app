class Submission < ApplicationRecord
  has_paper_trail only: [:state]

  include SubmissionPrintJobs
  include SubmissionAttributes
  include SubmissionHelpers
  include SubmissionTransitions

  belongs_to :delivery_address, class_name: "Address", required: false
  belongs_to :claimant, class_name: "User", required: false

  has_one :payment

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

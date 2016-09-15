class Submission < ApplicationRecord
  has_paper_trail only: [:state]

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
  has_one :registered_vessel, through: :registration

  default_scope do
    order("target_date asc").where.not(state: :completed)
  end

  scope :assigned_to, -> (claimant) { where(claimant: claimant) }

  scope :referred_until_expired, lambda {
    where("date(referred_until) <= ?", Date.today)
  }

  validates :part, presence: true
  validates :ref_no, presence: true

  def notification_list
    (correspondences + notifications + declarations.map(&:notification)
    ).compact.sort { |a, b| b.created_at <=> a.created_at }
  end

  def process_application; end

  def owners
    declarations.map(&:owner)
  end

  def vessel
    @vessel ||= Submission::Vessel.new(user_input[:vessel_info])
  end

  def applicant
    declarations.first.owner if declarations
  end

  def applicant_email
    applicant.email if applicant
  end

  def source
    "Online"
  end

  def ref_no_prefix
    "00"
  end

  protected

  def user_input
    changeset.blank? ? {} : changeset.deep_symbolize_keys!
  end
end

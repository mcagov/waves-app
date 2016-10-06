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
  has_one :registered_vessel, through: :registration, source: :vessel

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

  def applicant
    declarations.first.owner if declarations
  end

  def applicant_email
    applicant.email if applicant
  end

  def source
    "Online"
  end

  def job_type
    ""
  end

  def editable?
    !completed? && !printing?
  end

  protected

  def user_input
    changeset.blank? ? {} : changeset.deep_symbolize_keys!
  end

  def unassignable?
    true
  end

  def init_new_submission
    build_ref_no
  end

  def build_ref_no
    self.ref_no = RefNo.generate(ref_no_prefix)
  end

  def ref_no_prefix
    "00"
  end

  def build_declarations
    Builders::DeclarationBuilder.create(
      self,
      user_input[:owners],
      user_input[:declarations]
    )
  end

  def remove_claimant
    update_attribute(:claimant, nil)
  end

  def add_claimant(user)
    update_attribute(:claimant, user)
  end

  def init_processing_dates
    update_attribute(:received_at, Date.today)

    if payment.wp_amount.to_i == 7500
      update_attribute(:target_date, 5.days.from_now)
      update_attribute(:is_urgent, true)
    else
      update_attribute(:target_date, 20.days.from_now)
    end

    update_attribute(:referred_until, nil)
  end
end

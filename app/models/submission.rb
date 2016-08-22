class Submission < ApplicationRecord
  belongs_to :delivery_address, class_name: "Address", required: false
  belongs_to :claimant, class_name: "User", required: false

  has_one :payment

  validates :part, presence: true

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :incomplete
    state :unassigned
    state :assigned
    state :referred
    state :completed, enter: :process_application!
    state :print_queue

    event :paid do
      transitions to: :unassigned, from: :incomplete
    end

    event :claimed do
      transitions to: :assigned, from: :unassigned
    end

    event :unclaimed do
      transitions to: :unassigned, from: :assigned
    end

    event :complete! do
      transitions to: :completed, from: :assigned
    end
  end

  def process_application!; end

  default_scope { includes(:payment)}

  scope :assigned_to, lambda {|claimant| where(claimant: claimant)}

  PREMIUM_AMOUNT = 7500
  STANDARD_AMOUNT = 2500

  PREMIUM_DAYS = 5
  STANDARD_DAYS = 20

  # sortable attributes these need to be added to the database record
  def paid?
    payment.present?
  end

  def target_date
    created_at.advance(days: target_days).to_date if paid?
  end

  def target_days
    if payment.wp_amount.to_i == PREMIUM_AMOUNT
      PREMIUM_DAYS
    else
      STANDARD_DAYS
    end
  end

  # helper attributes
  def source
    'Online'
  end

  def vessel
    @vessel ||= Submission::Vessel.new(user_input[:vessel_info])
  end

  def owners
    @owners ||=
      (user_input[:owners] || []).map do |owner_params|
        Submission::Owner.new(owner_params)
      end
  end

  def declarations
    user_input[:declarations] || []
  end

  def declared_by?(email)
    declarations.include?(email)
  end

  def applicant
    owners.first if owners
  end

  protected

  def user_input
    @user_input ||=
      changeset.blank? ? {} : changeset.deep_symbolize_keys!
  end

end

class Submission < ApplicationRecord
  belongs_to :delivery_address, class_name: "Address", required: false
  belongs_to :claimant, class_name: "User", required: false
  has_one :payment
  has_many :notifications

  default_scope { includes(:payment).where.not(state: 'completed') }
  scope :assigned_to, lambda {|claimant| where(claimant: claimant)}

  validates :part, presence: true

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :incomplete
    state :unassigned
    state :assigned
    state :referred
    state :completed
    state :rejected

    event :paid do
      transitions to: :unassigned, from: :incomplete
    end

    event :claimed do
      transitions to: :assigned, from: [:unassigned, :rejected]
    end

    event :unclaimed do
      transitions to: :unassigned, from: :assigned,
        on_transition: :remove_claimant
    end

    event :approved do
      transitions to: :completed, from: :assigned
    end

    event :rejected do
      transitions to: :rejected, from: :assigned,
        on_transition: :remove_claimant
    end
  end

  def process_application; end

  def paid?
    payment.present?
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

  def source
    'Online'
  end

    # BEGIN configurable elements
  # do this in govuk
  PREMIUM_AMOUNT = 7500
  STANDARD_AMOUNT = 2500

  PREMIUM_DAYS = 5
  STANDARD_DAYS = 20

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
  # END



  protected

  def user_input
    @user_input ||=
      changeset.blank? ? {} : changeset.deep_symbolize_keys!
  end

  def remove_claimant
    update_attribute(:claimant, nil)
  end
end

class Submission < ApplicationRecord
  belongs_to :vessel, required: false
  belongs_to :delivery_address, class_name: "Address", required: false
  has_one :payment

  validates :part, presence: true

  PREMIUM_AMOUNT = 7500
  STANDARD_AMOUNT = 2500

  PREMIUM_DAYS = 5
  STANDARD_DAYS = 20

  # sortable attributes
  def paid?
    payment.present?
  end

  def target_date
    created_at.advance(days: target_days).to_date if paid?
  end

  # helper attributes

  def user_input
    # this needs to be safer
    @user_input ||= changeset.deep_symbolize_keys!
  end

  def vessel
    @vessel ||= Submission::Vessel.new(user_input[:vessel_info])
  end

  def owners
    vessel.owners
  end

  def declarations
    user_input[:declarations] || []
  end

  def declared_by?(owner)
    declarations.include?(owner[:email])
  end

  def target_days
    if payment.wp_amount.to_i == PREMIUM_AMOUNT
      PREMIUM_DAYS
    else
      STANDARD_DAYS
    end
  end

  # display attributes

  def applicant
    owners.first[:name] if owners
  end

  def owners
    user_input[:owners] || []
  end

  def job_type
    ""
  end

  def source
    'Online'
  end
end

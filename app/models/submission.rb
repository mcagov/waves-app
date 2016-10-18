class Submission < ApplicationRecord
  has_paper_trail only: [:state]

  include Submission::Associations
  include Submission::StateMachine

  validates :part, presence: true
  validates :ref_no, presence: true

  scope :referred_until_expired, lambda {
    where("date(referred_until) <= ?", Date.today)
  }

  def init_new_submission
    Builders::SubmissionBuilder.create(self)
  end

  def init_processing_dates
    Builders::ProcessingDatesBuilder.create(self)
  end

  def actionable?
    Policies::Submission.actionable?(self)
  end

  def approvable?(_registration_start_date = nil)
    Policies::Submission.approvable?(self)
  end

  def process_application(registration_starts_at)
    Builders::NewRegistrationBuilder.create(self, registration_starts_at)
  end

  def printing_completed?
    Policies::Submission.printing_completed?(self)
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

  def payment
    payments.first
  end

  protected

  def remove_claimant
    update_attribute(:claimant, nil)
  end

  def add_claimant(user)
    update_attribute(:claimant, user)
  end
end

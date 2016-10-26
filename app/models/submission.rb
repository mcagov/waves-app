class Submission < ApplicationRecord
  has_paper_trail only: [:state]

  include Submission::Associations
  include Submission::StateMachine

  validates :part, presence: true
  validates :ref_no, presence: true
  validates :source, presence: true
  validates :task, presence: true
  validate :registered_vessel_exists

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

  def editable?
    Policies::Submission.editable?(self)
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
    @vessel ||=
      Submission::Vessel.new(symbolized_changeset[:vessel_info] || {})
  end

  def vessel=(vessel_params)
    self.changeset ||= {}
    changeset[:vessel_info] = vessel_params
  end

  def delivery_address
    @delivery_address ||=
      Submission::DeliveryAddress.new(
        symbolized_changeset[:delivery_address] || {})
  end

  def delivery_address=(delivery_address_params)
    changeset[:delivery_address] = delivery_address_params
  end

  def correspondent
    declarations.first.owner unless declarations.empty?
  end

  def correspondent_email
    correspondent.email if correspondent
  end

  def job_type
    Task.description(task)
  end

  def symbolized_changeset
    changeset.blank? ? {} : changeset.deep_symbolize_keys!
  end

  def payment
    payments.first
  end

  def vessel_reg_no
    registered_vessel.reg_no if registered_vessel
  end

  def vessel_reg_no=(reg_no)
    self.registered_vessel = Register::Vessel.where(reg_no: reg_no).first
  end

  protected

  def remove_claimant
    update_attribute(:claimant, nil)
  end

  def add_claimant(user)
    update_attribute(:claimant, user)
  end

  def registered_vessel_exists
    if Policies::Submission.registered_vessel_required?(self)
      unless registered_vessel
        errors.add(:vessel_reg_no, "was not found in the Registry")
      end
    end
  end
end

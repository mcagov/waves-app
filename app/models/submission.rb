class Submission < ApplicationRecord
  include Submission::Associations
  include Submission::StateMachine

  validates :part, presence: true
  validates :source, presence: true
  validates :task, presence: true

  validates :task,
            inclusion: {
              in: Task.validation_helper_task_type_list,
              message: "must be selected" },
            unless: :officer_intervention_required?

  validate :ref_no, unless: :officer_intervention_required?

  validate :registered_vessel_exists,
           unless: :officer_intervention_required?

  before_update :build_defaults, if: :registered_vessel_id_changed?

  scope :in_part, ->(part) { where(part: part.to_sym) }
  scope :active, -> { where.not(state: [:completed]) }
  scope :referred_until_expired, lambda {
    where("date(referred_until) <= ?", Date.today)
  }

  after_touch :check_current_state

  delegate :registration_status, to: :registered_vessel, allow_nil: true

  def check_current_state
    unassigned! if incomplete? && actionable?
  end

  def electronic_delivery?
    symbolized_changeset[:electronic_delivery]
  end

  def build_defaults
    Builders::SubmissionBuilder.build_defaults(self)
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

  def uneditable?
    !editable?
  end

  def process_application(approval_params = {})
    Submission::ApplicationProcessor.run(self, approval_params)
  end

  def job_type
    Task.new(task).description
  end

  def symbolized_changeset
    changeset.blank? ? {} : changeset.deep_symbolize_keys!
  end

  def symbolized_registry_info
    registry_info.blank? ? {} : registry_info.deep_symbolize_keys!
  end

  def payment
    payments.first
  end

  def vessel_reg_no
    registered_vessel.reg_no if registered_vessel
  end

  def vessel_reg_no=(reg_no)
    self.registered_vessel =
      Register::Vessel.in_part(part).where(reg_no: reg_no).first
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
        errors.add(
          :vessel_reg_no,
          "was not found in the #{Activity.new(part)} Registry")
      end
    end
  end
end

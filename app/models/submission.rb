class Submission < ApplicationRecord
  include Submission::Associations
  include Submission::Reporting

  include PgSearch
  multisearchable against:
    [
      :ref_no,
      :vessel_reg_no,
      :vessel_search_attributes,
      :owner_search_attributes,
    ]

  validates :part, presence: true
  validates :source, presence: true

  validate :ref_no
  validate :registered_vessel_exists
  validate :vessel_uniqueness

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :active, enter: :build_defaults
    state :closed

    event :close, timestamp: :closed_at do
      transitions to: :closed, from: :active,
                  guard: :closeable?
    end
  end

  before_update :build_defaults, if: :registered_vessel_id_changed?

  scope :in_part, ->(part) { where(part: part.to_sym) if part }

  delegate :registration_status, to: :registered_vessel, allow_nil: true

  def closeable?
    tasks.active.empty? && tasks.initialising.empty?
  end

  def build_defaults
    Builders::SubmissionBuilder.build_defaults(self)
  end

  def job_type
    ApplicationType.new(application_type).description
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
    self.registered_vessel =
      Register::Vessel.in_part(part).where(reg_no: reg_no).first
  end

  def vessel_ec_no
    registered_vessel.ec_no if registered_vessel
  end

  def vessel_name
    return vessel.name if vessel.name.present?
    return registered_vessel.name if registered_vessel
    if finance_payment && finance_payment.vessel_name.present?
      finance_payment.vessel_name
    else
      "UNKNOWN"
    end
  end

  def name_approval
    Submission::NameApproval.where(submission: self).active[0]
  end

  def notification_list
    Builders::NotificationListBuilder.for_submission(self)
  end

  protected

  def registered_vessel_exists
    if Policies::Actions.registered_vessel_required?(self)
      unless registered_vessel
        errors.add(
          :vessel_reg_no,
          "was not found in the #{Activity.new(part)} Registry")
      end
    end
  end

  def vessel_uniqueness
    return false if registered_vessel_id.blank?

    existing_submission =
      Submission.where.not(id: id).active
                .find_by(registered_vessel_id: registered_vessel.id)

    if existing_submission
      errors.add(
        :vessel_reg_no,
        "An open application already exists for this vessel. "\
        "Ref No. #{existing_submission.ref_no}")
    end
  end

  def vessel_search_attributes
    vessel.search_attributes
  end

  def owner_search_attributes
    return if declarations.empty?
    owners.compact.map(&:inline_name_and_address).join("; ")
  end
end

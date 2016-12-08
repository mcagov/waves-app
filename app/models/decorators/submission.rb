class Decorators::Submission < SimpleDelegator
  def initialize(submission)
    @submission = submission
    super
  end

  def similar_vessels
    Search.similar_vessels(part, vessel)
  end

  def notification_list
    Builders::NotificationListBuilder.for_submission(@submission)
  end

  def vessel_name
    return vessel.name if vessel.name.present?
    if finance_payment && finance_payment.vessel_name.present?
      finance_payment.vessel_name
    else
      "Unknown"
    end
  end

  def source_description
    source.titleize if source
  end

  def previous_update_by
    ""
  end

  def display_registry_info?
    registry_info.present?
  end

  def display_changeset?
    Task.new(task).builds_registry?
  end

  def registry_vessel
    @registry_vessel ||=
      Submission::Vessel.new(symbolized_registry_info[:vessel_info] || {})
  end

  def registry_agent
    @registry_agent ||=
      Submission::Agent.new(symbolized_registry_info[:agent] || {})
  end

  def registry_owners
    return [] unless symbolized_registry_info[:owners]

    @registry_owners ||=
      symbolized_registry_info[:owners].map do |owner|
        Declaration::Owner.new(owner)
      end
  end

  def payment_status
    AccountLedger.new(@submission).payment_status
  end

  def payment_received
    AccountLedger.new(@submission).amount_paid
  end

  def declaration_status
    if declarations.empty?
      "Undefined"
    elsif incomplete_declarations.empty?
      "Complete"
    else
      "Incomplete"
    end
  end

  private

  def finance_payment
    payment.remittance if payment && source.to_sym == :manual_entry
  end
end

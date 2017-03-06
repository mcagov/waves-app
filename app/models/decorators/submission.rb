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

  def removed_registry_owners
    declaration_owner_names =
      declarations.map { |declaration| declaration.owner.name.upcase }

    registry_owners.delete_if do |registry_owner|
      declaration_owner_names.include?(registry_owner.name)
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

  def vessel_can_be_edited?
    Task.new(task).vessel_can_be_edited?
  end

  def ownership_can_be_changed?
    Task.new(task).ownership_can_be_changed?
  end

  def address_can_be_changed?
    Task.new(task).address_can_be_changed?
  end

  def new_registration?
    Task.new(task) == :new_registration
  end

  def vessel_attribute_changed?(attr_name)
    return false if new_registration?
    registry_vessel.send(attr_name).to_s.strip !=
      @submission.vessel.send(attr_name).to_s.strip
  end

  def delivery_description
    if electronic_delivery?
      "Electronic delivery"
    elsif delivery_address.active?
      delivery_address.inline_name_and_address
    end
  end

  def radio_call_sign
    vessel.radio_call_sign if vessel
  end

  def mmsi_number
    vessel.mmsi_number if vessel
  end

  def convertible?
    new_registration? || registered_vessel.present?
  end

  def tonnage_defined?
    return false unless vessel
    return true if vessel.net_tonnage
    return true if vessel.register_tonnage
    false
  end

  def can_issue_carving_and_marking?
    tonnage_defined? && vessel_reg_no
  end
end

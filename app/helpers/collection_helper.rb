module CollectionHelper
  def parts_collection
    Activity::PART_TYPES
  end

  def countries_collection
    WavesUtilities::Country.all.uniq
  end

  def nationalities_collection
    (["BRITISH"] << WavesUtilities::Nationality.all.uniq.sort).flatten
  end

  def last_registry_countries_collection
    WavesUtilities::Country.all.insert(1, "NONE")
  end

  def registration_types_collection(part)
    reg_types = WavesUtilities::RegistrationType.in_part(part) || []
    reg_types.sort { |a, b| a[0] <=> b[0] }.map do |registration_type|
      [registration_type.to_s.humanize, registration_type]
    end
  end

  def ports_collection
    WavesUtilities::Port.all
  end

  def registration_status_collection
    [:closed, :expired, :frozen, :pending, :registered].map do |status|
      [status.to_s.humanize, status]
    end
  end

  def available_priority_codes_collection(submission, mortgage)
    used_codes = (submission.mortgages - [mortgage]).map(&:priority_code)
    ("A".."Z").to_a - used_codes
  end

  def vessel_types_collection(submission)
    WavesUtilities::VesselType.all(
      submission.part,
      Policies::Definitions.fishing_vessel?(submission))
  end

  def eligibility_status_collection(submission)
    if Policies::Definitions.fishing_vessel?(submission)
      WavesUtilities::EligibilityStatus.fishing_vessels
    else
      WavesUtilities::EligibilityStatus.part_1_and_part_4_non_fishing
    end
  end

  def document_types_collection(part = nil)
    WavesUtilities::DocumentType.all(part)
  end

  def transaction_types_collection
    [["Income Report", :payments], ["Refunds Report", :refunds]]
  end

  def propulsion_system_collection(propulsion_system = nil)
    collection = WavesUtilities::PropulsionSystem.all
    # note that #to_s is to handle legacy propulsion_systems
    # that were previously defined as arrays
    collection << propulsion_system unless propulsion_system.to_s.blank?
    collection.uniq
  end

  def issuing_authorities_collection
    WavesUtilities::IssuingAuthority.all
  end

  def delivery_methods_collection
    [["Print a hard copy", :print], ["Send via Email", :email]]
  end

  def carving_and_marking_templates_collection
    CarvingAndMarking::TEMPLATES
  end

  def name_approved_until_collection
    [
      ["3 months", Date.today.advance(months: 3).to_s(:db)],
      ["10 years", Date.today.advance(years: 10).to_s(:db)],
    ]
  end

  def classification_society_collection(classification_society = nil)
    collection = WavesUtilities::ClassificationSociety.all
    collection << classification_society unless classification_society.blank?
    collection.uniq
  end

  def closure_reasons_collection
    reasons = WavesUtilities::Closure::REASONS
    reasons += WavesUtilities::Closure::INTERNAL_REASONS
    reasons.map { |r| r.to_s.humanize }.sort
  end

  def termination_reasons_collection
    WavesUtilities::TerminationReason.all
  end

  def filter_registration_type_collection(part)
    filter = registration_types_collection(part) || []
    filter.unshift(["All", "all"]) # rubocop:disable Style/WordArray
    filter << ["Not set", "not_set"]
  end

  def service_level_collection
    [["Standard", :standard], ["Premium", :premium]]
  end
end

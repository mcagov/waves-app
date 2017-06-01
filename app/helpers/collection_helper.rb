module CollectionHelper
  def parts_collection
    Activity::PART_TYPES
  end

  def owner_countries_collection
    ["UNITED KINGDOM"]
  end

  def nationalities_collection
    WavesUtilities::Nationality.all
  end

  def registration_types_collection(part)
    WavesUtilities::RegistrationType
      .in_part(part).sort { |a, b| a[0] <=> b[0] }.map do |registration_type|
      [registration_type.to_s.humanize, registration_type]
    end
  end

  def countries_collection
    WavesUtilities::Country.all
  end

  def ports_collection
    WavesUtilities::Port.all
  end

  def registration_status_collection
    [:closed, :expired, :frozen, :pending, :registered].map do |status|
      [status.to_s.humanize, status]
    end
  end

  def available_priority_codes_collection(submission)
    ("A".."Z").to_a - submission.mortgages.map(&:priority_code)
  end

  def vessel_types_collection(submission)
    WavesUtilities::VesselType.all(
      submission.part,
      Policies::Definitions.fishing_vessel?(submission))
  end

  def eligibility_status_collection(submission)
    if Policies::Definitions.part_4_non_fishing?(submission)
      WavesUtilities::EligibilityStatus.part_4_non_fishing
    else
      WavesUtilities::EligibilityStatus.all
    end
  end

  def document_types_collection(part = nil)
    WavesUtilities::DocumentType.all(part)
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

  def classification_society_collection
    WavesUtilities::ClassificationSociety.all
  end

  def closure_reasons_collection
    reasons = WavesUtilities::Closure::REASONS
    reasons += WavesUtilities::Closure::INTERNAL_REASONS
    reasons.map { |r| r.to_s.humanize }
  end
end

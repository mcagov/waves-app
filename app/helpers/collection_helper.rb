module CollectionHelper
  def owner_countries_collection
    ["UNITED KINGDOM"]
  end

  def nationalities_collection
    WavesUtilities::Nationality.all
  end

  def registration_types_collection
    WavesUtilities::RegistrationType.all.map do |registration_type|
      [registration_type.to_s.humanize, registration_type]
    end
  end

  def countries_collection
    WavesUtilities::Country.all
  end

  def ports_collection
    WavesUtilities::Port.all
  end

  def vessel_types_collection
    WavesUtilities::VesselType.all(current_activity.part)
  end

  def eligibility_status_collection
    WavesUtilities::EligibilityStatus.all
  end

  def document_types_collection
    WavesUtilities::DocumentType.all(current_activity.part)
  end

  def issuing_authorities_collection
    WavesUtilities::IssuingAuthority.all
  end

  def tonnage_types_collection
    [["Net Tonnage", :net_tonnage], ["Register Tonnage", :register_tonnage]]
  end

  def delivery_methods_collection
    [["Print a hard copy", :print], ["Send via Email", :email]]
  end
end

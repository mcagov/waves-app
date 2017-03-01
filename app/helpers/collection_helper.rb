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
    WavesUtilities::Port.all(current_activity.part)
  end

  def vessel_types_collection
    case current_activity.part.to_sym
    when :part_1, :part_4
      ["General Cargo Ship", "Barge"].map(&:upcase).freeze
    when :part_2
      ["Fishing Vessel"].map(&:upcase).freeze
    when :part_3
      WavesUtilities::VesselType.all
    end
  end
end

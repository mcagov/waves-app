class Document < Note
  scope :safety_certificates,
        lambda {
          where(entity_type: "fishing_vessel_safety_certificate")
        }

  scope :not_expired, -> { where("expires_at >= ?", Time.zone.now) }

  def entity_type_name
    WavesUtilities::DocumentType.new(entity_type).name
  end
end

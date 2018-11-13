class Document < Note
  scope :safety_certificates,
        lambda {
          where(entity_type: "safety_certificate")
        }

  scope :not_expired, -> { where("expires_at >= ?", Time.zone.now) }

  def entity_type_name
    if entity_type
      WavesUtilities::DocumentType.new(entity_type).name
    else
      "UNKNOWN"
    end
  end
end

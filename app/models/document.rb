class Document < Note
  def entity_type_name
    WavesUtilities::DocumentType.new(entity_type).name
  end
end

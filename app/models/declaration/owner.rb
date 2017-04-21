class Declaration::Owner < WavesUtilities::Owner
  def individual?
    (entity_type || "").to_sym != :corporate
  end
end

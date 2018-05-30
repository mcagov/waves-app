class Declaration::Owner < Customer
  def individual?
    (entity_type || "").to_sym != :corporate
  end
end

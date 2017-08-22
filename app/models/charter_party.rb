class CharterParty < Customer
  alias_attribute :declaration_signed, :custom_boolean

  scope :individual, -> { where("entity_type = 'individual'") }
  scope :corporate, -> { where("entity_type = 'corporate'") }
  scope :incomplete, -> { where(declaration_signed: false) }
end

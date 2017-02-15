module Register
  class Owner < Customer
    scope :individual, -> { where("entity_type = 'individual'") }
    scope :corporate, -> { where("entity_type = 'corporate'") }
  end
end

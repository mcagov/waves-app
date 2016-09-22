module Register
  class Owner < Customer
    belongs_to :vessel
  end
end

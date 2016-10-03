module Register
  class Owner < Customer
    belongs_to :vessel

    def to_s
      name.upcase
    end
  end
end

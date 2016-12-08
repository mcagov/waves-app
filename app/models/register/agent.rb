module Register
  class Agent < Customer
    belongs_to :vessel

    def to_s
      name.upcase
    end
  end
end

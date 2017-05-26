class Mortgagor < Customer
  belongs_to :mortgage, inverse_of: :mortgagors

  attr_accessor :owner_id
end

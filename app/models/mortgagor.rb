class Mortgagor < Customer
  belongs_to :mortgage, inverse_of: :mortgagors
end

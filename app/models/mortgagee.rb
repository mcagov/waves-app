class Mortgagee < Customer
  belongs_to :mortgage, inverse_of: :mortgagees
end

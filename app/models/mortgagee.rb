class Mortgagee < Customer
  belongs_to :mortgage, inverse_of: :mortgagees
  delegate :vessel, to: :parent
  delegate :part, to: :parent
end

class Mortgagor < Customer
  belongs_to :mortgage,
             inverse_of: :mortgagors,
             foreign_key: :parent_id,
             foreign_type: :parent_id
end

class Mortgagee < ApplicationRecord
  belongs_to :mortgage, inverse_of: :mortgagees
end

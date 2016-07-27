class OwnerAddress < ApplicationRecord
  belongs_to :owner
  belongs_to :address
end

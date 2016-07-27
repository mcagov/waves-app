class OwnerVessel < ApplicationRecord
  belongs_to :owner
  belongs_to :vessel
end

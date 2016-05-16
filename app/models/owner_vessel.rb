class OwnerVessel < ActiveRecord::Base
  belongs_to :owner
  belongs_to :vessel
end

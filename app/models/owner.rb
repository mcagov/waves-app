class Owner < ActiveRecord::Base
  has_many :owner_addresses
  has_many :addresses, through: :owner_addresses

  has_many :owner_vessels
  has_many :vessels, through: :owner_vessels
end

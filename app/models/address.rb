class Address < ActiveRecord::Base
  has_many :owner_addresses
  has_many :owners, through: :owner_addresses
end

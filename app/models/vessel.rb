class Vessel < ActiveRecord::Base
  has_many :owner_vessels
  has_many :owners, through: :owner_vessels

  has_many :vessel_registrations
  has_many :registrations, through: :vessel_registrations

  has_many :register_vessels
  has_many :registers, through: :register_vessels

  belongs_to :vessel_type
end

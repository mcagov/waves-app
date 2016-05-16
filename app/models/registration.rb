class Registration < ActiveRecord::Base
  has_many :vessel_registrations
  has_many :vessels, through: :vessel_registrations
end

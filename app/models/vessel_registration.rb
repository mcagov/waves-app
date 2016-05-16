class VesselRegistration < ActiveRecord::Base
  belongs_to :vessel
  belongs_to :registration

  has_many :user_vessel_registrations
  has_many :users, through: :user_vessel_registrations
end

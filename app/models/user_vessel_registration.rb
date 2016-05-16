class UserVesselRegistration < ActiveRecord::Base
  belongs_to :user
  belongs_to :vessel_registration
end

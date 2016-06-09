class UserVesselRegistration < ActiveRecord::Base
  belongs_to :user
  belongs_to :registration
end

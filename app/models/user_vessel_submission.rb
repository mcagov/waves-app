class UserVesselSubmission < ApplicationRecord
  belongs_to :user
  belongs_to :submission
end

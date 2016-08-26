class Registration < ApplicationRecord
  belongs_to :submission
  belongs_to :registered_vessel, class_name: "Register::Vessel", foreign_key: "vessel_id"
end

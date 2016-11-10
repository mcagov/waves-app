class Registration < ApplicationRecord
  belongs_to :submission, required: false
  belongs_to :actioned_by, class_name: "User", required: false
  belongs_to :vessel,
             class_name: "Register::Vessel", foreign_key: "vessel_id"
end

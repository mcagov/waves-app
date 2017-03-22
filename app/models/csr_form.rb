class CsrForm < ApplicationRecord
  belongs_to :submission
  belongs_to :registered_vessel,
             foreign_key: :vessel_id,
             class_name: "Register::Vessel"
end

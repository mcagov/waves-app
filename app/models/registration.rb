class Registration < ApplicationRecord
  belongs_to :vessel

  belongs_to :delivery_address, class_name: "Address"
end

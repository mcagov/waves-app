class Registration < ApplicationRecord
  belongs_to :vessel
  accepts_nested_attributes_for :vessel

  belongs_to :delivery_address, class_name: "Address"
  accepts_nested_attributes_for :delivery_address
end

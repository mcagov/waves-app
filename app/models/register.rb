class Register < ApplicationRecord
  has_many :register_vessels
  has_many :vessels, through: :register_vessels
end

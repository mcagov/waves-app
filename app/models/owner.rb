class Owner < ApplicationRecord
  ALLOWED_NATIONALITIES = [
    "GB"
  ].freeze

  include OwnerValidations

  has_many :owner_vessels
  has_many :vessels, through: :owner_vessels

  belongs_to :address
  accepts_nested_attributes_for :address
end

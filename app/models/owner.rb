class Owner < ActiveRecord::Base
  ALLOWED_NATIONALITIES = [
    "GB"
  ].freeze

  include OwnerValidations

  SUGGESTED_TITLES = [
    "Mr",
    "Mrs",
    "Miss",
    "Ms",
    "Doctor",
    "Reverend"
  ].freeze

  has_many :owner_vessels
  has_many :vessels, through: :owner_vessels

  belongs_to :address
  accepts_nested_attributes_for :address

  def full_name_with_title
    "#{title} #{first_name} #{last_name}"
  end
end

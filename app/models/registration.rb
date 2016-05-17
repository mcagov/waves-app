class Registration < ActiveRecord::Base
  has_many :vessel_registrations
  has_many :vessels, through: :vessel_registrations

  validates :not_registered_before_on_ssr, acceptance: true
  validates :not_registered_under_part_1, acceptance: true
  validates :owners_are_uk_residents, acceptance: true
  validates :user_eligible_to_register, acceptance: true
end

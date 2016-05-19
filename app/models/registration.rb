class Registration < ActiveRecord::Base
  has_many :vessel_registrations
  has_many :vessels, through: :vessel_registrations
  accepts_nested_attributes_for :vessels

  validates :not_registered_before_on_ssr, acceptance: true
  validates :not_registered_under_part_1, acceptance: true
  validates :owners_are_uk_residents, acceptance: true
  validates :user_eligible_to_register, acceptance: true

  validate :associated_vessel, if: :vessel_info_added?

  def vessel_info_added?
    status == :vessel_info_added
  end

  def associated_vessel?
    vessels.count > 0
  end
end

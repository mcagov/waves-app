class Registration < ActiveRecord::Base
  has_many :vessel_registrations
  has_many :vessels, through: :vessel_registrations
  accepts_nested_attributes_for :vessels

  validates :not_registered_before_on_ssr, acceptance: true
  validates :not_registered_under_part_1, acceptance: true
  validates :owners_are_uk_residents, acceptance: true
  validates :user_eligible_to_register, acceptance: true

  validates :eligible_under_regulation_89,
            acceptance: true,
            if: :declaration_accepted?
  validates :eligible_under_regulation_90,
            acceptance: true,
            if: :declaration_accepted?
  validates :understands_false_statement_is_offence,
            acceptance: true,
            if: :declaration_accepted?

  validate :associated_vessel?, if: :vessel_info_added?

  def vessel_info_added?
    status == "vessel_info_added"
  end

  def declaration_accepted?
    status == "declaration_accepted"
  end

  def associated_vessel?
    vessels.count > 0
  end
end

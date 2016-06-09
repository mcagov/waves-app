class Registration < ActiveRecord::Base
  belongs_to :vessel
  accepts_nested_attributes_for :vessel

  validates :not_registered_before_on_ssr, acceptance: true
  validates :not_registered_under_part_1, acceptance: true
  validates :not_owned_by_company, acceptance: true
  validates :not_commercial_fishing_or_submersible, acceptance: true
  validates :owners_are_uk_residents, acceptance: true
  validates :owners_are_eligible_to_register, acceptance: true
  validates :not_registered_on_foreign_registry, acceptance: true

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

  private

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

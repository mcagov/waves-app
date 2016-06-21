class Prerequisite
  include ActiveModel::Model

  attr_accessor(
    :not_registered_before_on_ssr,
    :not_registered_under_part_1,
    :not_owned_by_company,
    :not_commercial_fishing_or_submersible,
    :owners_are_uk_residents,
    :owners_are_eligible_to_register,
    :not_registered_on_foreign_registry
  )

  validates :not_registered_before_on_ssr, acceptance: true
  validates :not_registered_under_part_1, acceptance: true
  validates :not_owned_by_company, acceptance: true
  validates :not_commercial_fishing_or_submersible, acceptance: true
  validates :owners_are_uk_residents, acceptance: true
  validates :owners_are_eligible_to_register, acceptance: true
  validates :not_registered_on_foreign_registry, acceptance: true
end

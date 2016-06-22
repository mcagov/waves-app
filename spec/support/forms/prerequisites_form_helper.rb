def default_prerequisites_form_fields
  {
    not_registered_before_on_ssr: true,
    not_registered_under_part_1: true,
    not_owned_by_company: true,
    not_commercial_fishing_or_submersible: true,
    owners_are_uk_residents: true,
    owners_are_eligible_to_register: true,
    not_registered_on_foreign_registry: true
  }.freeze
end

def complete_prerequisites_form(fields = default_prerequisites_form_fields)
  fill_form_and_submit(:prerequisite, :update, fields)
end

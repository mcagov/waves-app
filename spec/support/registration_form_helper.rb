def error_message(field)
  t("activerecord.errors.models.registration.attributes.#{field}.accepted")
end

def path_for_step(step)
  registration_id = Registration.last.id
  step_string = I18n.t("wicked.#{step}")

  "/registration_wizard/#{step_string}?registration_id=#{registration_id}"
end

def complete_prerequisites_form(fields = default_prerequisites_form_fields)
  fill_form_and_submit(
    :registration,
    :update,
    fields
  )
end

def complete_vessel_info_form(fields = default_vessel_info_form_fields)
  fill_form_and_submit(
    :vessels,
    :update,
    fields
  )
end

def complete_owner_info_form
  click_on "Next"
end

def complete_declaration_form(fields = default_declaration_form_fields)
  fill_form_and_submit(
    :registration,
    :update,
    fields
  )
end

def default_prerequisites_form_fields
  {
    not_registered_before_on_ssr: true,
    not_registered_under_part_1: true,
    owners_are_uk_residents: true,
    user_eligible_to_register: true,
  }.freeze
end

def default_vessel_info_form_fields
  {
    name: "Boaty McBoatface",
    hin: random_hin,
    make_and_model: "Makey McMakeface",
    length_in_centimeters: "666",
    number_of_hulls: "1",
    vessel_type_id: random_vessel_type_designation.titleize,
    mmsi_number: random_uk_mmsi_number,
    radio_call_sign: "K12345",
  }
end

def default_declaration_form_fields
  {
    eligible_under_regulation_89: true,
    eligible_under_regulation_90: true,
    understands_false_statement_is_offence: true,
  }.freeze
end

def random_uk_mmsi_number
  "#{rand(232..235)}#{rand.to_s[2..7]}"
end

def random_hin
  "UK-#{rand.to_s[2..13]}"
end

def random_vessel_type_designation
  VesselType.all.sample.designation
end

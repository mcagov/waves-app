def error_message(field)
  t("activerecord.errors.models.registration.attributes.#{field}.accepted")
end

def path_for_step(step)
  registration_id = Registration.last.id
  step_string = I18n.t("wicked.#{step}")

  "/registration_wizard/#{step_string}?registration_id=#{registration_id}"
end

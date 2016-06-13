def error_message(field)
  t("activerecord.errors.models.registration.attributes.#{field}.accepted")
end

def path_for_step(step)
  registration_id = Registration.last.id
  step_string = I18n.t("wicked.#{step}")

  "/registration_wizard/#{step_string}?registration_id=#{registration_id}"
end

def complete_owner_info_form
  click_on I18n.t("helpers.submit.registration.update")
end

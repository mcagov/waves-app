def error_message(form_object, field)
  t("activemodel.errors.models.#{form_object}.attributes.#{field}.accepted")
end

def path_for_step(step)
  "/registration_process/#{step}"
end

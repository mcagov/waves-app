module PreregistrationsHelper
  def field_for_preregistration_form(form, field)
    form.input(
      field,
      {
        as: :boolean,
        label_html: {
          class: "block-label"
        }
      }
    )
  end
end

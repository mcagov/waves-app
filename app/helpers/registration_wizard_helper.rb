module RegistrationWizardHelper
  def form_checkbox(form, attribute)
    form.input(
      attribute,
      as: :boolean,
      wrapper: false,
      label_html: {class: "block-label"}
    )
  end
end

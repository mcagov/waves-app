class CurrencyInput < SimpleForm::Inputs::TextInput
  def input(_wrapper_options)
    @builder.text_field(
      attribute_name, class: "form-control has-feedback-left") +
      template.content_tag(:i, "£", class: "form-control-feedback left")
  end
end

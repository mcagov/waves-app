class CurrencyInput < SimpleForm::Inputs::Base
  def input
    @builder.text_field(
      attribute_name, class: "form-control has-feedback-left") +
      template.content_tag(:i, "£", class: "form-control-feedback left")
  end
end

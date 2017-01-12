class FeedbackLeftInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    @builder.text_field(
      attribute_name, class: "form-control has-feedback-left") +
      template.content_tag(:span, "", class: "form-control-feedback left")
  end
end

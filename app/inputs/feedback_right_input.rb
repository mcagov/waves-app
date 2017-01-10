class FeedbackRightInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    @builder.text_field(
      attribute_name, class: "form-control has-feedback-right") +
      template.content_tag(:i, "", class: "form-control-feedback right")
  end
end

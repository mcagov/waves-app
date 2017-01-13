class FeedbackInput < SimpleForm::Inputs::FileInput
  def input(_wrapper_options)
    @builder.text_field(
      attribute_name, input_html_options) +
      template.content_tag(
        :span,
        feedback_label,
        class: "form-control-feedback #{placement}")
  end

  def input_html_options
    super.deep_merge({
      readonly: options[:readonly],
      class: "form-control has-feedback-#{placement}"
    })
  end

  def feedback_label
    options[:feedback_label]
  end

  def placement
    options[:placement]
  end
end

class HinInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    hin = self.object.hin
    hin_prefix, hin_suffix = hin[0..1], hin[3..-1] if hin.present?

    [
      text_field("prefix", hin_prefix, 2),
      "&ndash;",
      text_field("suffix", hin_suffix, 12)
    ].join(" ").html_safe
  end

  def label_target
    :"#{attribute_name}"
  end

  private

  def text_field(key, value, field_length)
    template.text_field(
      :"#{attribute_name}", key, input_field_options(value, field_length)
    )
  end

  def input_field_options(value, field_length)
    input_html_options.merge(
      class: "form-control",
      maxlength: field_length,
      placeholder: ("X" * field_length),
      size: field_length,
      style: "width: initial;",
      value: (value || "")
    )
  end
end

class LengthInCentimetersInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    length = self.object.length_in_centimeters
    metres, centimetres = (length / 100), (length % 100) if length.present?

    [
      number_field("m", metres, 23),
      "metres",
      number_field("cm", centimetres, 99),
      "centimetres"
    ].join(" ").html_safe
  end

  private

  def number_field(key, value, field_length)
    template.number_field(
      :"#{attribute_name}", key, input_field_options(value, field_length)
    )
  end

  def input_field_options(value, field_length)
    input_html_options.merge(
      class: "form-control",
      max: field_length,
      min: 0,
      placeholder: "0",
      style: "width: initial;",
      value: (value || 0)
    )
  end
end

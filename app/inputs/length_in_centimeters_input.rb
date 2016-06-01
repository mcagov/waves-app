class LengthInCentimetersInput < BaseInput
  def input(wrapper_options = nil)
    length = self.object.length_in_centimeters
    metres, centimetres = (length / 100), (length % 100) if length.present?

    [
      number_field("m", input_field_options(metres, 23)),
      "metres",
      number_field("cm", input_field_options(centimetres, 99)),
      "centimetres"
    ].join(" ").html_safe
  end

  private

  def input_field_options(value, maximum_value)
    default_options.merge(
      max: maximum_value,
      min: 0,
      placeholder: "0",
      value: (value || 0)
    )
  end
end

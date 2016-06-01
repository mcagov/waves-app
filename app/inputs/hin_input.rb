class HinInput < BaseInput
  def input(wrapper_options = nil)
    hin = self.object.hin
    prefix, suffix = hin[0..1], hin[3..-1] if hin.present?

    [
      text_field("prefix", input_field_options(prefix, 2)),
      "&ndash;",
      text_field("suffix", input_field_options(suffix, 12))
    ].join(" ").html_safe
  end

  private

  def input_field_options(value, field_length)
    default_options.merge(
      maxlength: field_length,
      placeholder: ("X" * field_length),
      size: field_length,
      value: (value || "")
    )
  end
end

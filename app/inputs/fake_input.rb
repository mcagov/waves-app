class FakeInput < BaseInput
  def input(wrapper_options = nil)
    merged_options = merge_wrapper_options(input_html_options, wrapper_options)
    name = "#{object_name}[#{attribute_name}]"

    template.text_field_tag(name, nil, merged_options)
  end
end

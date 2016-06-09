class BaseInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    raise NotImplementedError
  end

  def label_target
    :"#{attribute_name}"
  end

  protected

  def text_field(attribute_key, options = default_options)
    template.text_field(:"#{attribute_name}", attribute_key, options)
  end

  def number_field(attribute_key, options = default_options)
    template.number_field(:"#{attribute_name}", attribute_key, options)
  end

  def default_options
    input_html_options.merge(
      class: "form-control",
      style: "width: initial;"
    )
  end
end

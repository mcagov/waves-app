module RegistrationWizardHelper
  def form_checkbox(form, attribute)
    form.input(
      attribute,
      as: :boolean,
      label_html: {class: "block-label"},
      wrapper: false,
    )
  end

  def form_input(form, attribute, options = {})
    wrapper_class = "form-group"
    wrapper_class += " error" if form.object.errors.messages[attribute].present?
    options.merge!(wrapper_html: {class: wrapper_class})

    form.input(attribute, options)
  end

  def form_input_id(form, attribute)
    match_data = form.input_field(attribute).match(/id="(\w+)"/)
    match_data ? match_data[1] : nil
  end

  def form_select(form, attribute, collection, options = {})
    merged_options = options.merge(
      collection: collection,
      prompt: :translate
    )

    form_input(form, attribute, merged_options)
  end

  def number_of_hulls_collection
    (1..6).map { |x| [x.to_s, x] }
  end

  def vessel_type_collection
    vessels = VesselType.all.each_with_object([]) do |vessel_type, memo|
      memo << [vessel_type.designation.titleize, vessel_type.id]
    end

    vessels << [nil, nil, {disabled: true}]
    vessels << ["Other (please specify)", nil]
  end
end

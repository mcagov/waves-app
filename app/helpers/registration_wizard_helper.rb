module RegistrationWizardHelper
  def form_checkbox(form, attribute)
    form.input(
      attribute,
      as: :boolean,
      wrapper: false,
      label_html: { class: "block-label" }
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

  def form_country_select(form, attribute, options = {})
    merged_options = options.merge(
      as: :country,
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

  def owner_title_collection
    titles = Owner::SUGGESTED_TITLES.map do |title|
      [title, title]
    end

    titles << [nil, nil, {disabled: true}]
    titles << ["Other (please specify)", nil]
  end

  def selected_owner_title(form)
    return nil if form.object.title.nil?
    return "" unless Owner::SUGGESTED_TITLES.include?(form.object.title)
    form.object.title
  end

  def other_owner_title(form)
    return "" if Owner::SUGGESTED_TITLES.include?(form.object.title)
    form.object.title
  end

  def delivery_address_toggle(form)
    form.input(
      :delivery_address_toggle,
      as: :radio_buttons,
      checked: false,
      collection: [["No", false], ["Yes", true]],
      input_html: {
        "checked" => "",
        "data-target" => "registration-delivery-address"
      },
      item_label_class: "block-label",
      item_wrapper_tag: nil,
      label: false
    )
  end
end

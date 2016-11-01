module EditableSubmissionHelper
  def editable_vessel(title, name, value, reg_info_value,
                      css = "editable-text", source = nil)

    link_to editable_value(value, reg_info_value),
            "#",
            class: css,
            data: {
              title: title,
              name: name,
              url: submission_vessel_path(@submission),
              emptytext: editable_emptytext(value, reg_info_value),
              source: source }
  end

  # rubocop:disable Metrics/ParameterLists
  def editable_owner(title, name, value, reg_info_value,
                     declaration, css = "editable-text", source = nil)

    link_to editable_value(value, reg_info_value),
            "#",
            class: css,
            data: {
              title: title,
              name: name,
              url: declaration_owners_path(declaration),
              emptytext: editable_emptytext(value, reg_info_value),
              source: source }
  end

  def editable_value(value, reg_info_value)
    value == reg_info_value ? "" : value
  end

  def editable_emptytext(value, reg_info_value)
    value == reg_info_value ? "No change" : ""
  end

  def editable_link_to(boolean, *link_to_params)
    link_to_if boolean, *link_to_params
  end

  def editable_delivery_address(attr_title, attr_name, attr_value)
    editable_link_to(
      @submission.editable?,
      attr_value, "#",
      class: "editable-delivery-address",
      "data-name" => attr_name,
      "data-value" => attr_value,
      "data-url" => submission_delivery_addresses_path(@submission),
      "data-title" => attr_title)
  end

  def editable_delivery_country(attr_value)
    editable_link_to(
      @submission.editable?,
      attr_value, "#",
      class: "editable-delivery-country",
      "data-name" => "delivery_address[country]",
      "data-value" => attr_value,
      "data-url" => submission_delivery_addresses_path(@submission),
      "data-title" => "Country",
      "data-source" => all_country_list.to_json)
  end
end

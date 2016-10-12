module EditableSubmissionHelper
  def editable_link_to(boolean, *link_to_params)
    link_to_if boolean, *link_to_params
  end

  def editable_vessel(attr_title, attr_name, attr_value)
    editable_link_to(
      @submission.editable?,
      attr_value, "#",
      class: "editable-text",
      "data-name" => attr_name,
      "data-value" => attr_value,
      "data-url" => submission_vessels_path(@submission),
      "data-title" => attr_title)
  end

  def editable_vessel_type(attr_value)
    editable_link_to(
      @submission.editable?,
      attr_value, "#",
      class: "editable-select",
      "data-name" => "vessel[vessel_type]",
      "data-value" => attr_value,
      "data-url" => submission_vessels_path(@submission),
      "data-title" => "Vessel type",
      "data-source" => vessel_type_list.to_json)
  end

  def editable_number_of_hulls(attr_value)
    editable_link_to(
      @submission.editable?,
      attr_value, "#",
      class: "editable-select",
      "data-name" => "vessel[number_of_hulls]",
      "data-value" => attr_value,
      "data-url" => submission_vessels_path(@submission),
      "data-title" => "Number of hulls",
      "data-source" => (1..6).to_a.to_json)
  end

  def editable_owner(attr_title, attr_name, attr_value, declaration)
    editable_link_to(
      @submission.editable?,
      attr_value, "#",
      class: "editable-owner-address",
      "data-name" => attr_name,
      "data-value" => attr_value,
      "data-url" => declaration_owners_path(declaration),
      "data-title" => attr_title)
  end

  def editable_owner_email(attr_title, attr_name, attr_value, declaration)
    editable_link_to(
      @submission.editable?,
      attr_value, "#",
      class: "editable-email",
      "data-name" => attr_name,
      "data-value" => attr_value,
      "data-url" => declaration_owners_path(declaration),
      "data-title" => attr_title)
  end

  def editable_owner_country(attr_value, declaration)
    editable_link_to(
      @submission.editable?,
      attr_value, "#",
      class: "editable-owner-country",
      "data-name" => "owner[country]",
      "data-value" => attr_value,
      "data-url" => declaration_owners_path(declaration),
      "data-title" => "Country",
      "data-source" => owner_country_list.to_json)
  end

  def editable_owner_nationality(attr_value, declaration)
    editable_link_to(
      @submission.editable?,
      attr_value, "#",
      class: "editable-select",
      "data-name" => "owner[nationality]",
      "data-value" => attr_value,
      "data-url" => declaration_owners_path(declaration),
      "data-title" => "Nationality",
      "data-source" => nationality_list.to_json)
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

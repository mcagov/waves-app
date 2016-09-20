module EditableHelper
  def editable_vessel(attr_title, attr_name, attr_value)
    link_to attr_value, "#",
            class: "editable-text",
            "data-name" => attr_name,
            "data-value" => attr_value,
            "data-url" => submission_vessels_path(@submission),
            "data-title" => attr_title
  end

  def editable_number_of_hulls(attr_value)
    link_to attr_value, "#",
            class: "editable-select",
            "data-name" => "vessel[number_of_hulls]",
            "data-value" => attr_value,
            "data-url" => submission_vessels_path(@submission),
            "data-title" => "Number of hulls",
            "data-source" => (1..6).to_a.to_json
  end

  def editable_owner(attr_title, attr_name, attr_value, declaration)
    link_to attr_value, "#",
            class: "editable-text",
            "data-name" => attr_name,
            "data-value" => attr_value,
            "data-url" => declaration_owners_path(declaration),
            "data-title" => attr_title
  end

  def editable_owner_country(attr_value, declaration)
    link_to attr_value, "#",
            class: "editable-select",
            "data-name" => "owner[country]",
            "data-value" => attr_value,
            "data-url" => declaration_owners_path(declaration),
            "data-title" => "Country",
            "data-source" => eligible_country_list.to_json
  end
end

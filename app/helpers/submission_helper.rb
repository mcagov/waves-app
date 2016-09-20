module SubmissionHelper
  def css_tick(bln)
    if bln
      content_tag(:div, " ", class: "i fa fa-check green")
    else
      content_tag(:div, " ", class: "i fa fa-times red")
    end
  end

  # rubocop:disable Metrics/MethodLength
  def action_for(submission, officer)
    case submission.current_state
    when :unassigned
      "Unclaimed queue"
    when :referred, :cancelled, :rejected
      submission.current_state.to_s.humanize
    when :assigned
      "Claimed by #{officer}"
    when :approved
      "Approved by #{officer}"
    else
      submission.current_state
    end
  end

  def similar_attribute_icon(key, vessel_attr, similar_vessel_attr)
    if vessel_attr.to_s == similar_vessel_attr.to_s && vessel_attr.present?
      # NOTE: once we set the similar-#{key} class, a javascript
      # functions (submission.js) displays a star next to the
      # reciprocal attribute in the vessel pane
      content_tag(:div, "", class: "i fa fa-star-o similar-#{key}")
    end
  end

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
end

module SubmissionHelper
  def css_tick(bln)
    if bln
      content_tag(:div, " ", class: "i fa fa-check green")
    else
      content_tag(:div, " ", class: "i fa fa-times red")
    end
  end

  def action_for(submission, officer)
    case submission.current_state
    when :unassigned
      "Unclaimed queue"
    when :referred, :cancelled, :rejected
      submission.current_state.to_s.humanize
    when :assigned
      "Claimed by #{officer}"
    else
      submission.current_state
    end
  end

  def similar_attribute_icon(key, vessel_attr, similar_vessel_attr)
    # rubocop: disable Style/GuardClause
    if vessel_attr.to_s == similar_vessel_attr.to_s && vessel_attr.present?
      # NOTE: once we set the similar-#{key} class, a javascript
      # functions (submission.js) displays a star next to the
      # reciprocal attribute in the vessel pane
      content_tag(:div, "", class: "i fa fa-star-o similar-#{key}")
    end
  end
end

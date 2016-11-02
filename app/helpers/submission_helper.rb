module SubmissionHelper
  def payment_status_icon(payment_status)
    case payment_status
    when :paid
      content_tag(:div, " ", class: "i fa fa-check green")
    when :part_paid
      content_tag(:div, " ", class: "i fa fa-check-circle-o")
    when :unpaid
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
    if vessel_attr.to_s == similar_vessel_attr.to_s && vessel_attr.present?
      # NOTE: once we set the similar-#{key} class, a javascript
      # function (submission.js) displays a star next to the
      # reciprocal attribute in the vessel pane
      content_tag(:div, "", class: "i fa fa-star-o similar-#{key}")
    end
  end

  def vessel_label(attr)
    t("simple_form.labels.submission.vessel.#{attr}")
  end
end

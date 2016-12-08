module SubmissionHelper
  def payment_status_icon(payment_status)
    case payment_status
    when :paid
      content_tag(:div, " ", class: "i fa fa-check green")
    when :part_paid
      content_tag(:div, " ", class: "i fa fa-check-circle-o")
    when :unpaid
      content_tag(:div, " ", class: "i fa fa-times red")
    when :not_applicable
      "n/a"
    end
  end

  def action_for(submission, officer)
    case submission.current_state
    when :unassigned
      "Unclaimed queue"
    when :referred, :cancelled
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

  def default_referred_until
    WavesDate.next_working_day(30.days.from_now)
  end

  def compare_reg_info(value, reg_info_value)
    if value == reg_info_value
      "<div class='no-change'>No change</div>".html_safe
    else
      value
    end
  end
end

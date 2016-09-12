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
end

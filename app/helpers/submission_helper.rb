module SubmissionHelper
  def css_tick(bln)
    if bln
      content_tag(:div, ' ', class: 'i fa fa-check green')
    else
      content_tag(:div, ' ', class: 'i fa fa-times red')
    end
  end
end

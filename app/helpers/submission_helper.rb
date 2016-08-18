module SubmissionHelper
  def inline_address(hsh)
    [
      hsh[:address_1],
      hsh[:address_2],
      hsh[:address_3],
      hsh[:town],
      hsh[:county],
      hsh[:country],
      hsh[:postcode]
    ].compact.reject(&:empty?).join(", ")
  end

  def css_tick(bln)
    if bln
      content_tag(:div, ' ', class: 'i fa fa-check green')
    else
      content_tag(:div, ' ', class: 'i fa fa-times red')
    end
  end
end

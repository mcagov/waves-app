class Pdfs::Part3::RenewalReminderLetterWriter <
  Pdfs::RenewalReminderLetterWriter

  def write
    page_1
    page_2
    page_3
    page_4
    page_5

    @pdf
  end

  protected

  def page_1
    @pdf.start_new_page
    draw_bg(1)
    init_stationary(@registration.updated_at)

    set_bold_font
    @pdf.draw_text @vessel[:name], at: [l_margin, 530]

    @pdf.font("Helvetica-Bold", size: 10)
    @pdf.draw_text "#{ENV['GOVUK_HOST']}.", at: [80, 384]

    @pdf.font("Helvetica", size: 9)
    @pdf.draw_text @registration.registered_until, at: [320, 463]
    @pdf.draw_text @registration.registered_until, at: [310, 273]
  end

  def page_2
    @pdf.start_new_page
    draw_bg(2)
    @pdf.draw_text @vessel[:name], at: [170, 636]
    @pdf.draw_text @vessel[:reg_no], at: [170, 610]

    @pdf.font("Helvetica", size: 9, style: :italic)
    @pdf.draw_text "#{ENV['GOVUK_HOST']}.", at: [216, 498]
  end

  def page_3
    @pdf.start_new_page
    draw_bg(3)
  end

  def page_4
    @pdf.start_new_page
    draw_bg(4)
  end

  def page_5
    @pdf.start_new_page
    draw_bg(5)
  end

  def draw_bg(p)
    dir = "#{Rails.root}/public/pdf_images/renewals/"
    @pdf.image "#{dir}part_3_registration_renewal_letter-#{p}.png",
               scale: 0.35, at: [-26, 810]
  end
end

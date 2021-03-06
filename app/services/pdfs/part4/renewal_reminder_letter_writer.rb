class Pdfs::Part4::RenewalReminderLetterWriter <
  Pdfs::RenewalReminderLetterWriter

  def write
    page_1
    page_2
    page_3
    page_4

    @pdf
  end

  protected

  def page_1
    @pdf.start_new_page
    draw_bg(1)
    init_stationary(@registration.updated_at)

    set_bold_font
    @pdf.draw_text @vessel[:name], at: [l_margin, 520]

    @pdf.font("Helvetica-Bold", size: 10)
    @pdf.draw_text @registration.registered_until, at: [320, 473]
  end

  def page_2
    @pdf.start_new_page
    draw_bg(2)
    details_box
  end

  def page_3
    @pdf.start_new_page
    draw_bg(3)
  end

  def page_4
    @pdf.start_new_page
    draw_bg(4)
  end

  def draw_bg(p)
    dir = "#{Rails.root}/public/pdf_images/renewals/"
    @pdf.image "#{dir}part_4_registration_renewal_letter-#{p}.png",
               scale: 0.35, at: [-26, 810]
  end

  def details_box
    @pdf.draw_text @vessel[:name], at: [170, 642]
    @pdf.draw_text @vessel[:reg_no], at: [170, 614]
  end
end

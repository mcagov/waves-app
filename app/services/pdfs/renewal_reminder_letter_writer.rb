class Pdfs::RenewalReminderLetterWriter
  include Pdfs::Stationary

  def initialize(registration, pdf)
    @registration = registration
    @vessel = @registration.registered_vessel
    @applicant_name = @vessel.correspondent
    @delivery_name_and_address = @registration.delivery_name_and_address

    @pdf = pdf
  end

  def write
    @pdf.start_new_page
    draw_bg(1)
    init_stationary(@registration.updated_at)
    vessel_name
    @pdf.start_new_page
    draw_bg(2)
    @pdf.start_new_page
    draw_bg(3)
    @pdf.start_new_page
    draw_bg(4)
    @pdf
  end

  protected

  def draw_bg(p)
    @pdf.image "#{Rails.root}/public/pdf_images/renewals/part_1_registration_renewal_letter-#{p}.png",
      scale: 0.35, at: [-26,810]
  end

  def vessel_name
    set_bold_font
    @pdf.draw_text @vessel[:name], at: [l_margin, 530]
  end
end

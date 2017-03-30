class Pdfs::TerminationNoticeWriter
  include Pdfs::Stationary

  def initialize(registration, pdf)
    @registration = registration
    @vessel = @registration.vessel
    @correspondent = @registration.correspondent
    @deliver_to = @registration.delivery_address
    @pdf = pdf
  end

  def write
    @pdf.start_new_page
    init_stationary
    vessel_name
    message
    @pdf
  end

  protected

  def vessel_name
    set_bold_font
    @pdf.draw_text @vessel[:name], at: [l_margin, 530]
  end

  def message
    set_copy_font
    @pdf.draw_text "Pending text", at: [l_margin, 510]
  end
end
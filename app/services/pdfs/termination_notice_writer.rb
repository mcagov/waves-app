class Pdfs::TerminationNoticeWriter
  include Pdfs::Stationary

  def initialize(termination_notice, pdf)
    @termination_notice = termination_notice
    @vessel = @termination_notice.vessel
    @delivery_name_and_address = []

    @pdf = pdf
  end

  def write
    @pdf.start_new_page
    init_stationary(@termination_notice.updated_at)
    vessel_name
    message
    @pdf
  end

  protected

  def vessel_name
    set_bold_font
    @pdf.draw_text @vessel.name, at: [l_margin, 530]
  end

  def message
    set_copy_font
    @pdf.draw_text "Termination Notice", at: [l_margin, 510]
  end
end

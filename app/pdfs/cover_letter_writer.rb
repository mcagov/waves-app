class CoverLetterWriter
  def initialize(registration, pdf)
    @registration = registration
    @vessel = @registration.vessel
    @pdf = pdf
  end

  def write
    @pdf.start_new_page
    @pdf.draw_text("Dear Bob", at: [300, 300])
    @pdf
  end
end

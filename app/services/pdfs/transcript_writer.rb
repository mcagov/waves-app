class Pdfs::TranscriptWriter
  def initialize(registration, pdf, mode = :printable)
    @registration = registration
    @vessel = @registration.vessel
    @owners = @registration.owners
    @pdf = pdf
    @mode = mode
  end

  def write
    @pdf.start_new_page
    @pdf.draw_text "Hello, Transcript", at: [100, 600]
    @pdf
  end
end

class Pdfs::Transcript
  def initialize(registrations)
    @registrations = Array(registrations)
    @mode = :attachment
    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @registrations.each do |registration|
      @pdf =
        Pdfs::TranscriptWriter.new(registration, @pdf, @mode).write
    end

    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    "transcript.pdf"
  end
end

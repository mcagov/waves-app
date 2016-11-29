class Pdfs::Transcript
  def initialize(registrations, mode = :printable)
    @registrations = Array(registrations)
    @template = :current
    @mode = mode

    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @registrations.each do |registration|
      @pdf =
        Pdfs::TranscriptWriter.new(registration, @pdf, @template).write
    end

    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    if @registrations.length == 1
      single_transcript_filename
    else
      "transcripts.pdf"
    end
  end

  protected

  def single_transcript_filename
    registration = @registrations.first
    title = registration.vessel.to_s.parameterize
    "#{title}-transcript.pdf"
  end
end

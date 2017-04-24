class Pdfs::HistoricTranscript
  def initialize(registrations, mode = :printable)
    @registered_vessels = Array(registrations).map(&:registered_vessel)
    @template = :historic
    @mode = mode

    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @registered_vessels.each do |registered_vessel|
      registered_vessel.registrations.each do |registration|
        @pdf = transcript_writer(registration).write
      end
    end

    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    if @registered_vessels.length == 1
      "#{@registered_vessels[0].to_s.parameterize}-transcript.pdf"
    else
      "transcripts.pdf"
    end
  end
end

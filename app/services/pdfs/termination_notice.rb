class Pdfs::TerminationNotice
  def initialize(termination_notices, mode = :printable)
    @termination_notices = Array(termination_notices)
    @template = :current
    @mode = mode
    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @termination_notices.each do |termination_notice|
      @pdf =
        Pdfs::TerminationNoticeWriter.new(termination_notice, @pdf).write
    end

    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    "termination-notices.pdf"
  end
end

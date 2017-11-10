class Pdfs::SectionNotice
  def initialize(section_notices, mode = :printable)
    @section_notices = Array(section_notices)
    @template = :current
    @mode = mode
    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @section_notices.each do |section_notice|
      @pdf = Pdfs::SectionNoticeWriter.new(section_notice, @pdf).write
    end

    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    "section-notices.pdf"
  end
end

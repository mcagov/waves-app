class Pdfs::MortgageeReminderLetter
  def initialize(mortgagees, mode = :printable)
    @mortgagees = Array(mortgagees)
    @template = :current
    @mode = mode
    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @mortgagees.each do |mortgagee|
      @pdf =
        Pdfs::MortgageeReminderLetterWriter.new(mortgagee, @pdf).write
    end

    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    "mortgagee-renewal-reminder.pdf"
  end
end

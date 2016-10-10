class CoverLetter
  def initialize(registrations)
    @registrations = Array(registrations)
    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @registrations.each do |registration|
      @pdf = CoverLetterWriter.new(registration, @pdf).write
    end
    PdfRender.new(@pdf).render
  end

  def filename
    if @registrations.length == 1
      single_cover_letter_filename
    else
      "cover-letters.pdf"
    end
  end

  protected

  def single_cover_letter_filename
    registration = @registrations.first
    title = registration.vessel.to_s.parameterize
    reg_date = registration.registered_at.to_s(:db)
    "#{title}-cover-letter-#{reg_date}.pdf"
  end
end

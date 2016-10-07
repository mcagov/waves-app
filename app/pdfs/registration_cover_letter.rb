class RegistrationCoverLetter
  def initialize(registration)
    @registration = registration
    @vessel = @registration.vessel
  end

  def render
    @pdf = Prawn::Document.new(margin: 0, page_size: "A4")
    @pdf.draw_text("Dear Bob", at: [300, 300])
    @pdf.print
    @pdf.render
  end

  def filename
    "Bobs-file"
  end
end

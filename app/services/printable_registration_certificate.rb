class PrintableRegistrationCertificate < RegistrationCertificate
  def render
    @pdf = Prawn::Document.new(margin: 0, page_size: "A6")
    registration_details
    @pdf.print
    @pdf.render
  end
end

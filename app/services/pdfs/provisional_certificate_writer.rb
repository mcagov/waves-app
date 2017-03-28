class Pdfs::ProvisionalCertificateWriter
  def initialize(registration, pdf, template = :current)
    @registration = registration
    @vessel = @registration.vessel
    @owners = @registration.owners
    @pdf = pdf
    @template = template
  end

  def write
    @pdf.start_new_page
    @pdf.draw_text "Pending content", at: [700, 500]
    @pdf
  end
end

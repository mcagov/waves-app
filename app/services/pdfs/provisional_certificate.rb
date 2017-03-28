class Pdfs::ProvisionalCertificate
 def initialize(registrations, mode = :printable)
    @registrations = Array(registrations)
    @mode = mode
    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @registrations.each do |registration|
      @pdf =
        Pdfs::ProvisionalCertificateWriter.new(registration, @pdf, @mode).write
    end
    Pdfs::PdfRender.new(@pdf, @mode).render
  end


  def filename
    if @registrations.length == 1
      single_certificate_filename
    else
      "provisional-certificates.pdf"
    end
  end

  protected

  def single_certificate_filename
    registration = @registrations.first
    title = registration.vessel_name.parameterize
    "#{title}-provisional-certificate.pdf"
  end
end

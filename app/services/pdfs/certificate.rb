class Pdfs::Certificate
  def initialize(registrations, mode = :printable, duplicate = false)
    @registrations = Array(registrations)
    @mode = mode
    @duplicate = duplicate
    @pdf = Prawn::Document.new(
      margin: 0, page_size: paper_size, skip_page_creation: true)
  end

  def render
    @registrations.each do |registration|
      @pdf = certificate_writer(registration).write
    end
    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    if @registrations.length == 1
      single_registration_filename
    else
      "certificates-of-registry.pdf"
    end
  end

  protected

  def single_registration_filename
    registration = @registrations.first
    title = registration.vessel_name.parameterize
    reg_date = registration.registered_at.to_s(:db)
    "#{title}-registration-#{reg_date}.pdf"
  end
end

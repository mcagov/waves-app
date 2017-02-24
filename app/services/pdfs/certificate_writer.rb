class Pdfs::CertificateWriter
  def initialize(registration, pdf, mode = :printable)
    @registration = registration
    @vessel = @registration.vessel
    @owners = @registration.owners
    @pdf = pdf
    @mode = mode
  end

  def write
    write_attachable if @mode == :attachment
    write_printable if @mode == :printable
    @pdf
  end

  protected

  def default_value_font
    @pdf.font("Helvetica-BoldOblique", size: 10)
  end

  def default_label_font
    @pdf.font("Helvetica-Oblique", size: 10)
  end
end

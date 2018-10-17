class Pdfs::CertificateWriter
  def initialize(registration, pdf, mode = :printable, duplicate = false)
    @registration = registration
    @vessel = Decorators::Vessel.new(@registration.vessel)
    @owners = @registration.owners
    @engines = @registration.engines
    @pdf = pdf
    @mode = mode
    @duplicate = duplicate
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

  def format_decimal(input)
    format("%.2f", input || 0)
  end
end

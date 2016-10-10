class PdfRender
  def initialize(pdf = nil, mode = :printable)
    @pdf = pdf || Prawn::Document.new
    @mode = mode
  end

  def render
    @pdf.print if @mode == :printable
    @pdf.render
  end
end

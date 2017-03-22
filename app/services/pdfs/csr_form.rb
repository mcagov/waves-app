class Pdfs::CsrForm
  def initialize(csr_forms, mode = :printable)
    @csr_forms = Array(csr_forms)
    @mode = mode
    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @csr_forms.each do |csr_form|
      @pdf =
        Pdfs::CsrFormWriter.new(csr_form, @pdf, @template).write
    end
    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    if @csr_forms.length == 1
      single_csr_form_filename
    else
      "csr-forms.pdf"
    end
  end

  protected

  def single_csr_form_filename
    csr_form = @csr_forms.first
    title = csr_form.vessel_name.parameterize
    "#{title}-csr-form-#{Date.today.to_s(:db)}.pdf"
  end
end

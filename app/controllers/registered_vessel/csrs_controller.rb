class RegisteredVessel::CsrsController < InternalPagesController
  def show
    @csr_form = CsrForm.find(params[:id])
    respond_to do |format|
      format.pdf { build_and_render_pdf }
    end
  end

  protected

  def build_and_render_pdf
    if @csr_form
      pdf = Pdfs::Processor.run(:csr_form, @csr_form, :attachment)
      render_pdf(pdf, pdf.filename)
    end
  end
end

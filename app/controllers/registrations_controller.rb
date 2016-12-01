class RegistrationsController < InternalPagesController
  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.html do
        @registered_vessel = @registration.registered_vessel
        @print_jobs = PrintJob.where(printable: @registration)
      end

      format.pdf { build_and_render_pdf }
    end
  end

  protected

  def build_and_render_pdf
    @pdf = Pdfs::Processor.run(:registration_certificate, @registration)
    render_pdf(@pdf, @pdf.filename)
  end
end

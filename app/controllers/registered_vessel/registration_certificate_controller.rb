class RegisteredVessel::RegistrationCertificateController <
  InternalPagesController
  def show
    @vessel = Register::Vessel.find(params[:vessel_id])
    respond_to do |format|
      format.pdf { build_and_render_pdf }
    end
  end

  protected

  def build_and_render_pdf
    registration = @vessel.current_registration
    if registration
      pdf = Pdfs::Processor.run(registration.certificate_template,
                                registration)

      render_pdf(pdf, pdf.filename)
    end
  end
end

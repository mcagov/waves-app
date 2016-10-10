class Registration::CertificatesController < InternalPagesController
  layout :false

  def show
    @registration = Registration.find(params[:id])
    pdf = Certificate.new(@registration)
    @registration.submission.update_print_job!(:registration_certificate)

    render_pdf(pdf, pdf.filename)
  end
end

class Registration::CertificatesController < InternalPagesController
  layout :false

  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.pdf do
        pdf = Certificate.new(@registration)
        render_pdf(pdf, pdf.filename)
      end
    end
  end
end

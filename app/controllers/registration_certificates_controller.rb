class RegistrationCertificatesController < InternalPagesController
  layout :false

  def show
    @vessel = Register::Vessel.find(params[:id])

    respond_to do |format|
      format.pdf do
        pdf = PrintableRegistrationCertificate.new(@vessel)
        send_data pdf.render, filename: pdf.filename,
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
end

class RegistrationCertificatesController < InternalPagesController
  layout :false

  def show
    @vessel = Register::Vessel.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        pdf = RegistrationCertificate.new(@vessel)
        send_data pdf.render, filename: pdf.filename,
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
end

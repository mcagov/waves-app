class Registration::CoverLettersController < InternalPagesController
  layout :false

  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.pdf do
        pdf = RegistrationCoverLetter.new(@registration)
        send_data pdf.render, filename: pdf.filename,
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
end

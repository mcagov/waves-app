class VesselsController < InternalPagesController
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

  def index
    @vessels =
      Register::Vessel.paginate(page: params[:page], per_page: 20).order(:name)
  end
end

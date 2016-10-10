class Registration::CoverLettersController < InternalPagesController
  layout :false

  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.pdf do
        pdf = CoverLetter.new(@registration)

        render_pdf(pdf, pdf.filename)
      end
    end
  end
end

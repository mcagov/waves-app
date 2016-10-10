class Registration::CoverLettersController < InternalPagesController
  layout :false

  def show
    @registration = Registration.find(params[:id])
    pdf = CoverLetter.new(@registration)
    @registration.submission.update_print_job!(:cover_letter)

    render_pdf(pdf, pdf.filename)
  end
end

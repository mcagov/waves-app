class Registration::CoverLettersController < InternalPagesController
  layout :false

  def show
    @registration = Registration.find(params[:id])
    pdf = Pdfs::CoverLetter.new(@registration)
    PrintWorker.new(@registration.submission).update_job!(:cover_letter)

    render_pdf(pdf, pdf.filename)
  end
end

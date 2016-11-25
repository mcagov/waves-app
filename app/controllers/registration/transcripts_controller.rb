class Registration::TranscriptsController < InternalPagesController
  layout :false

  def show
    @registration = Registration.find(params[:id])
    pdf = Pdfs::Transcript.new(@registration)

    render_pdf(pdf, pdf.filename)
  end
end

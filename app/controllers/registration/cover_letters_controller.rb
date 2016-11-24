class Registration::CoverLettersController < InternalPagesController
  layout :false

  def show
    @registration = Registration.find(params[:id])
    pdf = Pdfs::CoverLetter.new(@registration)

    submission = Submission.find_by(ref_no: @registration.submission_ref_no)
    PrintWorker.new(submission).update_job!(:cover_letter)

    render_pdf(pdf, pdf.filename)
  end
end

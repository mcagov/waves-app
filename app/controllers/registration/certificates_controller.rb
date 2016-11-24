class Registration::CertificatesController < InternalPagesController
  layout :false

  def show
    @registration = Registration.find(params[:id])
    pdf = Pdfs::Certificate.new(@registration)

    submission = Submission.find_by(ref_no: @registration.submission_ref_no)
    PrintWorker.new(submission).update_job!(:registration_certificate)

    render_pdf(pdf, pdf.filename)
  end
end

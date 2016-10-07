class PrintQueue::CertificatesController < InternalPagesController
  def index
    @submissions = Submission.printing

    respond_to do |format|
      format.html
      format.pdf do
        registration = @submissions.first.registration
        pdf = RegistrationCertificate.new(registration, :printable)
        send_data pdf.render, filename: "Certificates-of-Registry",
                              type: "application/pdf", disposition: "inline"
      end
    end
  end
end

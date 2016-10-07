class PrintQueue::CertificatesController < InternalPagesController
  def index
    @submissions = Submission.printing

    respond_to do |format|
      format.html
      format.pdf do
        pdf = Certificate.new(@submissions.map(&:registration))
        send_data pdf.render, filename: pdf.filename,
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
end

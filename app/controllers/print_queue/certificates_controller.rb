class PrintQueue::CertificatesController < InternalPagesController
  def index
    @submissions = Submission.printing
  end
end

class PrintQueue::CertificatesController < InternalPagesController
  def index
    @print_jobs = [] # PrintJob.all
  end
end

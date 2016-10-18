class PrintQueue::CertificatesController < PrintQueue::BaseController
  protected

  def mark_submissions_printed
    @submissions.map do |submission|
      PrintWorker.new(submission).update_job!(:registration_certificate)
    end
  end
end

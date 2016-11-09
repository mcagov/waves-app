class PrintQueue::CoverLettersController < PrintQueue::BaseController
  protected

  def mark_submissions_completed
    @submissions.map do |submission|
      PrintWorker.new(submission).update_job!(:cover_letter)
    end
  end
end

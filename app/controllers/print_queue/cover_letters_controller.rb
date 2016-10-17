class PrintQueue::CoverLettersController < PrintQueue::BaseController
  protected

  def mark_submissions_printed
    @submissions.map do |submission|
      PrintWorker.new(submission).update_job!(:cover_letter)
    end
  end
end

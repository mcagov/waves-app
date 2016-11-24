class PrintQueue::BaseController < InternalPagesController
  before_action :load_submissions

  def index
    respond_to do |format|
      format.html
      format.pdf do
        load_registrations
        pdf = Pdfs::Certificate.new(@registrations)
        mark_submissions_completed

        render_pdf(pdf, pdf.filename)
      end
    end
  end

  protected

  def load_submissions
    @submissions =
      Submission
      .where(part: current_activity.part)
      .includes(:registration).printing
      .map { |submission| Decorators::Submission.new(submission) }
  end

  def load_registrations
    @registrations = @submissions.map(&:registration)
  end

  def mark_submissions_completed
    raise NotImplemented
  end

  class NotImplemented < StandardError; end
end

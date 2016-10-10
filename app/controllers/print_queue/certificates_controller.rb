# move this to a print queue controller
# that takes input :print_job_type

class PrintQueue::CertificatesController < InternalPagesController
  before_action :load_submissions

  def index
    respond_to do |format|
      format.html

      format.pdf do
        load_registrations
        pdf = Certificate.new(@registrations)

        # when we implement a modal, the user will click
        # "completed" to call an update method that marks
        # the submissions printed
        mark_submissions_printed

        send_data pdf.render, filename: pdf.filename,
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  protected

  def load_submissions
    @submissions = Submission
                   .includes([registration: [vessel: [:owners]]]).printing
  end

  def load_registrations
    @registrations = @submissions.map(&:registration)
  end

  def mark_submissions_printed
    @submissions.map do |submission|
      submission.update_print_job!(:registration_certificate)
    end
  end
end

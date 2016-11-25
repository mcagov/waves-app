class PrintJobsController < InternalPagesController
  layout :false

  def show
    @print_job = PrintJob.find(params[:id])
    @pdf = build_pdf(@print_job, @print_job.template)

    mark_as_printed(@print_job)

    render_pdf(@pdf, @pdf.filename)
  end

  private

  def build_pdf(print_jobs, template)
    printable_items = Array(print_jobs).map(&:printable)

    case template.to_sym
    when :registration_certificate
      Pdfs::Certificate.new(printable_items)
    when :cover_letter
      Pdfs::CoverLetter.new(printable_items)
    when :current_transcript
      Pdfs::Transcript.new(printable_items)
    end
  end

  def mark_as_printed(printed_jobs)
    Array(printed_jobs).each do |printed_job|
      printed_job.update_attributes(
        printed_at: Time.now, printed_by: current_user)
    end
  end
end

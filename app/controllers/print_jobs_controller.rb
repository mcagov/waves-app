class PrintJobsController < InternalPagesController
  def show
    respond_to do |format|
      format.pdf do
        @print_job = scoped_print_job.find(params[:id])
        @pdf = build_pdf(@print_job, @print_job.template)
        mark_as_printed(@print_job)
        render_pdf(@pdf, @pdf.filename)
      end
    end
  end

  def index
    @template = params[:template]
    @print_jobs = scoped_print_job.where(template: @template).unprinted

    respond_to do |format|
      format.html
      format.pdf do
        @pdf = build_pdf(@print_jobs, @template)
        mark_as_printed(@print_jobs)
        render_pdf(@pdf, "#{@template}.pdf")
      end
    end
  end

  private

  def build_pdf(print_jobs, template)
    printable_items = Array(print_jobs).map(&:printable)
    Pdfs::Processor.run(template, printable_items)
  end

  def mark_as_printed(printed_jobs)
    Array(printed_jobs).each do |printed_job|
      printed_job.update_attributes(
        printed_at: Time.now, printed_by: current_user)
    end
  end

  def scoped_print_job
    PrintJob.in_part(current_activity.part)
  end
end

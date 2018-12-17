class PrintJobsController < InternalPagesController
  def show
    respond_to do |format|
      format.pdf do
        @unprinted_job = scoped_print_job.find(params[:id])
        @pdf = build_pdf(@unprinted_job, @unprinted_job.template)
        mark_as_printing(@unprinted_job)
        render_pdf(@pdf, @pdf.filename)
      end
    end
  end

  def index
    @template = params[:template]
    load_print_jobs(@template)

    respond_to do |format|
      format.html
      format.pdf do
        @pdf = build_pdf(@unprinted_jobs, @template)
        mark_as_printing(@unprinted_jobs)
        render_pdf(@pdf, "#{@template}.pdf")
      end
    end
  end

  def update
    @print_job = scoped_print_job.find(params[:id])
    @print_job.printed!(current_user)

    respond_to do |format|
      format.js
    end
  end

  private

  def build_pdf(print_jobs, template)
    printable_items = Array(print_jobs).map(&:printable)
    Pdfs::Processor.run(template, printable_items)
  end

  def mark_as_printing(print_jobs)
    Array(print_jobs).each do |print_job|
      print_job.printing!(current_user) if print_job.can_printing?
    end
  end

  def scoped_print_job
    PrintJob.in_part(current_activity.part)
  end

  def load_print_jobs(template)
    @unprinted_jobs = scoped_print_job
                      .where(template: template)
                      .order("created_at asc").unprinted

    @printing_jobs = scoped_print_job
                     .where(template: template)
                     .order("printing_at asc").printing
                     .where("printing_at > ?", 30.days.ago)
  end
end

class RegisteredVessel::CsrsController < InternalPagesController
  before_action :load_vessel, only: [:create]

  def show
    @csr_form = CsrForm.find(params[:id])
    respond_to do |format|
      format.pdf { build_and_render_pdf }
    end
  end

  def create
    create_issue_csr_submission
    log_work!(@submission, @submission, :manual_override)

    redirect_to submission_path(@submission)
  end

  protected

  def build_and_render_pdf
    if @csr_form
      pdf = Pdfs::Processor.run(:csr_form, @csr_form, :attachment)
      render_pdf(pdf, pdf.filename)
    end
  end

  def create_issue_csr_submission
    @submission =
      Builders::AssignedSubmissionBuilder.create(
        :issue_csr,
        @vessel.part,
        @vessel,
        current_user)
  end
end

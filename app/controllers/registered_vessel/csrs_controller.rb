class RegisteredVessel::CsrsController < InternalPagesController
  before_action :load_vessel, only: [:create, :update]
  before_action :load_csr_form, only: [:show, :update]

  def show
    respond_to do |format|
      format.pdf { build_and_render_pdf }
    end
  end

  def create
    create_issue_csr_submission
    log_work!(@submission, @submission, :manual_override)

    redirect_to submission_path(@submission)
  end

  def update
    @csr_form.update_attributes(csr_form_params)

    respond_to do |format|
      format.js { @modal_id = params[:modal_id] }
    end
  end

  protected

  def load_csr_form
    @csr_form = CsrForm.find(params[:id])
  end

  def csr_form_params
    params.require(:csr_form).permit(:issue_number)
  end

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

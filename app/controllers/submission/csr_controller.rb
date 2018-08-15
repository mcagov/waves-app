class Submission::CsrController < InternalPagesController
  before_action :load_submission
  before_action :load_task
  before_action :enable_readonly

  def show
    @csr_form = Builders::CsrFormBuilder.build(@submission)
  end

  def update
    @csr_form = @submission.csr_form
    @csr_form.update_attributes(csr_form_params)

    respond_to do |format|
      format.js { render "/submissions/extended/forms/update" }
    end
  end

  protected

  def csr_form_params
    params.require(:csr_form).permit(CsrForm.attribute_names)
  end
end

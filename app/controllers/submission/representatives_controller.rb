class Submission::RepresentativesController < InternalPagesController
  before_action :load_submission

  def update
    @submission.update_attributes(submission_representative_params)

    render_update_js
  end

  def destroy
    @submission.representative = {}
    @submission.save

    render_update_js
  end

  protected

  def submission_representative_params
    params.require(:submission).permit(
      representative: [Customer.attribute_names])
  end

  def render_update_js
    respond_to do |format|
      format.js do
        @submission = Decorators::Submission.new(load_submission)
        render "/submissions/extended/forms/representatives/update.js"
      end
    end
  end
end

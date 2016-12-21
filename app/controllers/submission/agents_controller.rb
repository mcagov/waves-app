class Submission::AgentsController < InternalPagesController
  before_action :load_submission

  def update
    @submission.update_attributes(submission_agent_params)

    render_update_js
  end

  def destroy
    @submission.agent = {}
    @submission.save

    render_update_js
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part).find(params[:submission_id])
  end

  def submission_agent_params
    params.require(:submission).permit(
      agent: [:name, :email, :phone_number, :nationality, :address_1,
              :address_2, :address_3, :town, :postcode, :country])
  end

  def render_update_js
    respond_to do |format|
      format.js do
        @submission = Decorators::Submission.new(load_submission)
        render "/submissions/forms/agent/update.js"
      end
    end
  end
end

class Submission::DeclarationGroupsController < InternalPagesController
  before_action :load_submission

  def create
    @declaration_group = Declaration::Group.new(declaration_group_params)
    @declaration_group.submission = @submission
    @declaration_group.save

    @modal_id = params[:modal_id]

    respond_to do |format|
      format.js { render "/submissions/extended/forms/shareholding/update" }
    end
  end

  def shares_held
    @declaration_group = Declaration::Group.find(params[:id])

    @declaration_group.update_attributes(
      shares_held: declaration_group_params[:shares_held])
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part)
                .includes(:declarations).find(params[:submission_id])
  end

  def declaration_group_params
    params.require(:declaration_group)
          .permit(:default_group_member, :shares_held)
  end
end

class Submission::DeclarationGroupMembersController < InternalPagesController
  before_action :load_submission

  def create
    @declaration_group_member =
      Declaration::GroupMember.create(declaration_group_member_params)

    @modal_id = params[:modal_id]

    respond_to do |format|
      format.js { render "/submissions/extended/forms/shareholding/update" }
    end
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part)
                .includes(:declarations).find(params[:submission_id])
  end

  def declaration_group_member_params
    params.require(:declaration_group_member)
          .permit(:declaration_id, :declaration_group_id)
  end
end

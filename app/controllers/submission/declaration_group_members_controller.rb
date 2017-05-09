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

  def destroy
    Declaration::GroupMember.find(params[:id]).destroy

    @modal_id = params[:modal_id]

    respond_to do |format|
      format.js { render "/submissions/extended/forms/shareholding/update" }
    end
  end

  protected

  def declaration_group_member_params
    params.require(:declaration_group_member)
          .permit(:declaration_id, :declaration_group_id)
  end
end

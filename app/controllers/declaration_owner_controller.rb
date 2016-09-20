class DeclarationOwnerController < InternalPagesController
  before_action :load_declaration_and_owner

  def update
    @owner.assign_attributes(owner_params)
    @declaration.update_attributes(changeset: @owner)

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  protected

  def load_declaration_and_owner
    @declaration = Declaration.find(params[:declaration_id])
    @owner = @declaration.owner
  end

  def owner_params
    params.require(:owner).permit(:name)
  end
end

class DeclarationOwnerController < InternalPagesController
  before_action :load_declaration_and_owner

  def update
    @owner.assign_attributes(Transformer.upcase_params(owner_params))
    @declaration.update_attributes(changeset: @owner)

    render json: {
      status: 200, target_id: @declaration.id,
      inline_address: @declaration.owner.inline_address
    }
  end

  protected

  def load_declaration_and_owner
    @declaration = Declaration.find(params[:declaration_id])
    @owner = @declaration.owner
  end

  def owner_params
    params.require(:owner).permit(
      :name, :email, :phone_number, :nationality,
      :address_1, :address_2, :address_3,
      :town, :postcode, :country)
  end
end

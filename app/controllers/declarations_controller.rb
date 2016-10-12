class DeclarationsController < InternalPagesController
  before_action :load_declaration

  def update
    declaration_params ||= {}
    declaration_params[:completed_by] = current_user
    @declaration.update_attributes(declaration_params)
    @declaration.declared!
  end

  protected

  def load_declaration
    @declaration = Declaration.find(params[:id])
  end

  def declaration_params
    params.require(:declaration).permit(
      :completed_forms) || {}
  end
end

class DeclarationsController < InternalPagesController
  before_action :load_declaration

  def update
    @declaration.update_attributes(completed_by: current_user)
    @declaration.declared!

    respond_to { |format| format.js }
  end

  protected

  def load_declaration
    @declaration = Declaration.find(params[:id])
  end
end

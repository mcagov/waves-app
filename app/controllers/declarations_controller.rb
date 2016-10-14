class DeclarationsController < InternalPagesController
  before_action :load_declaration

  def update
    @declaration.completed_form = declaration_params[:completed_form]
    @declaration.completed_by = current_user

    @declaration.declared! if @declaration.save

    respond_to do |format|
      format.js
      format.html { redirect_to submission_path(@declaration.submission) }
    end
  end

  protected

  def load_declaration
    @declaration = Declaration.find(params[:id])
  end

  def declaration_params
    params.require(:declaration).permit(:completed_form)
  end
end

class DeclarationsController < InternalPagesController
  before_action :load_declaration

  def update
    @declaration.completed_by = current_user
    @declaration.declared! if @declaration.save

    redirect_to submission_path(@declaration.submission)
  end

  protected

  def load_declaration
    @declaration = Declaration.find(params[:id])
  end
end

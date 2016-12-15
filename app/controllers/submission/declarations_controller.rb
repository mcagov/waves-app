class Submission::DeclarationsController < InternalPagesController
  before_action :load_submission

  def create
    raise "CREATE"
  end

  def update
    raise "UPDATE"
  end

  def complete
    load_declaration
    @declaration.completed_by = current_user
    @declaration.declared! if @declaration.save

    redirect_to submission_path(@declaration.submission)
  end

  protected

  def load_submission
    @submission = Submission.find(params[:submission_id])
  end

  def load_declaration
    @declaration = @submission.declarations.find(params[:id])
  end
end

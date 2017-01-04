class Submission::DeclarationsController < InternalPagesController
  before_action :load_submission

  def create
    @declaration = Declaration.new(declaration_params)
    @declaration.submission = @submission
    @declaration.save

    sign_declaration if @declaration.declaration_signed == "true"

    @modal_id = "new_declaration"
    render_update_js
  end

  def update
    load_declaration
    @declaration.update_attributes(declaration_params)

    sign_declaration if @declaration.declaration_signed == "true"

    @modal_id = "declaration_#{@declaration.id}"
    render_update_js
  end

  def complete
    load_declaration
    sign_declaration

    redirect_to submission_path(@declaration.submission)
  end

  def destroy
    load_declaration
    @declaration.delete

    render_update_js
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part)
                .includes(:declarations).find(params[:submission_id])
  end

  def load_declaration
    @declaration = @submission.declarations.find(params[:id])
  end

  def declaration_params
    params.require(:declaration).permit(
      :id, :_destroy, :declaration_signed,
      owner: [:name, :email, :phone_number, :nationality, :address_1,
              :address_2, :address_3, :town, :postcode])
  end

  def render_update_js
    respond_to do |format|
      format.js do
        @submission = Decorators::Submission.new(load_submission)
        render "/submissions/forms/owners/update.js"
      end
    end
  end

  def sign_declaration
    @declaration.completed_by = current_user
    @declaration.declared! if @declaration.save
  end
end
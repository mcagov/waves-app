class Registration::DeclarationController < Registration::BaseController
  before_action :fetch_from_session

  def show
    @declaration = Declaration.new
  end

  def update
    @declaration = Declaration.new(declaration_params)

    if @declaration.valid?
      store_in_session(:owner_info, declaration_params)
      return redirect_to controller: :payment, action: :show
    end

    render :show
  end

  private

  def fetch_from_session
    @owner = get_from_session(:owner_info)
    @vessel = get_from_session(:vessel_info)
  end

  def declaration_params
    params.require(:declaration).permit(
      :eligible_under_regulation_89,
      :eligible_under_regulation_90,
      :understands_false_statement_is_offence
    )
  end
end

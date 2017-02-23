class Submission::MortgagesController < InternalPagesController
  before_action :load_submission

  def create
    @mortgage = Mortgage.new(mortgage_params)
    @mortgage.parent = @submission
    @mortgage.save

    respond_with_update
  end

  def update
    @mortgage = Mortgage.find(params[:id])
    @mortgage.update_attributes(mortgage_params)

    respond_with_update
  end

  def destroy
    @mortgage = Mortgage.find(params[:id])
    @mortgage.destroy

    respond_with_update
  end

  private

  def load_submission
    @submission =
      Submission
      .in_part(current_activity.part).find(params[:submission_id])
  end

  def mortgage_params
    params.require(:mortgage).permit(
      :mortgage_type, :reference_number, :start_date,
      :end_date, :amount, :mortgagor,
      mortgagees_attributes: [
        :id, :name, :address, :contact_details, :_destroy])
  end

  def respond_with_update
    respond_to do |format|
      @modal_id = params[:modal_id]
      format.js { render "/submissions/extended/forms/mortgages/update" }
    end
  end
end

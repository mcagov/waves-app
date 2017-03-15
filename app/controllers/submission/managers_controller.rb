class Submission::ManagersController < InternalPagesController
  before_action :load_submission

  def create
    @manager = Manager.new(manager_params)
    @manager.parent = @submission
    @manager.save!

    respond_with_update
  end

  def update
    @manager = Manager.find(params[:id])
    @manager.update_attributes(manager_params)

    respond_with_update
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy

    respond_with_update
  end

  private

  def load_submission
    @submission =
      Submission
      .in_part(current_activity.part).find(params[:submission_id])
  end

  def manager_params
    params.require(:manager).permit(
      :name, :email, :phone_number, :imo_number, :eligibility_status,
      :nationality, :address_1, :address_2, :address_3, :town, :postcode)
  end

  def respond_with_update
    respond_to do |format|
      @modal_id = params[:modal_id]
      format.js do
        render "/submissions/extended/forms/managers/update"
      end
    end
  end
end

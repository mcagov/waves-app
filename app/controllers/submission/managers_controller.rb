class Submission::ManagersController < InternalPagesController
  before_action :load_submission

  def create
    @manager = Manager.new(manager_params)
    @manager.parent = @submission
    @manager.save!

    @manager.safety_management.destroy if params[:use_above_address]

    respond_with_update
  end

  def update
    @manager = Manager.find(params[:id])
    @manager.update_attributes(manager_params)

    @manager.safety_management.destroy if params[:use_above_address]

    respond_with_update
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy

    respond_with_update
  end

  private

  def manager_params
    params.require(:manager).permit(
      Customer.attribute_names,
      safety_management_attributes: Customer.attribute_names + [:_destroy])
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

class Submission::ManagedBysController < InternalPagesController
  before_action :load_submission

  def create
    @managed_by = ManagedBy.new(managed_by_params)
    @managed_by.parent = @submission
    @managed_by.save!

    respond_with_update
  end

  def update
    @managed_by = ManagedBy.find(params[:id])
    @managed_by.update_attributes(managed_by_params)

    respond_with_update
  end

  def destroy
    @managed_by = ManagedBy.find(params[:id])
    @managed_by.destroy

    respond_with_update
  end

  private

  def managed_by_params
    params.require(:managed_by).permit(Customer.attribute_names)
  end

  def respond_with_update
    respond_to do |format|
      @modal_id = params[:modal_id]
      format.js do
        render "/submissions/extended/forms/managed_by/update"
      end
    end
  end
end

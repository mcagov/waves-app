class Submission::DirectedBysController < InternalPagesController
  before_action :load_submission

  def create
    @directed_by = DirectedBy.new(directed_by_params)
    @directed_by.parent = @submission
    @directed_by.save!

    respond_with_update
  end

  def update
    @directed_by = DirectedBy.find(params[:id])
    @directed_by.update_attributes(directed_by_params)

    respond_with_update
  end

  def destroy
    @directed_by = DirectedBy.find(params[:id])
    @directed_by.destroy

    respond_with_update
  end

  private

  def load_submission
    @submission =
      Submission
      .in_part(current_activity.part).find(params[:submission_id])
  end

  def directed_by_params
    params.require(:directed_by).permit(Customer.attribute_names)
  end

  def respond_with_update
    respond_to do |format|
      @modal_id = params[:modal_id]
      format.js do
        render "/submissions/extended/forms/directed_by/update"
      end
    end
  end
end

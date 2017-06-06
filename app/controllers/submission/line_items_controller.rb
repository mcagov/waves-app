class Submission::LineItemsController < InternalPagesController
  before_action :load_submission
  before_action :load_fee, only: :create
  before_action :load_line_item, only: [:update, :destroy]

  def create
    @line_item =
      Submission::LineItem.create(
        submission_id: @submission.id,
        fee_id: @fee.id,
        price: @fee.price)

    respond_with_update
  end

  def update
    @line_item.update_attributes(line_item_params)

    respond_with_update
  end

  def destroy
    @line_item.destroy

    respond_with_update
  end

  private

  def load_submission
    @submission =
      Submission
      .in_part(current_activity.part)
      .includes({ payments: [:remittance] }, :line_items)
      .find(params[:submission_id])
  end

  def load_fee
    @fee = Fee.find(params[:fee_id])
  end

  def load_line_item
    @line_item = Submission::LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:submission_line_item).permit(
      :price_in_pounds, :premium_addon_price_in_pounds)
  end

  def respond_with_update
    respond_to do |format|
      format.js do
        load_submission
        @modal_id = params[:modal_id]
        render "/submission/line_items/update"
      end
    end
  end
end

class Submission::LineItemsController < InternalPagesController
  before_action :load_submission
  before_action :load_fee

  def create
    @line_item =
      LineItem.create(
        submission_id: @submission.id,
        fee_id: @fee.id,
        price: @fee.price)

    load_submission
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

  def respond_with_update
    respond_to do |format|
      format.js { render "/submission/line_items/update" }
    end
  end
end

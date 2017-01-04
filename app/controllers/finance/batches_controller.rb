class Finance::BatchesController < InternalPagesController
  def index
  end

  def create
    @batch =
      FinanceBatch.create(
        opened_at: Time.now,
        processed_by: current_user
      )

    redirect_to new_finance_batch_payment_path(@batch)
  end

  def update
    @batch = FinanceBatch.find(params[:id])
    @batch.toggle_state!

    redirect_to finance_batch_payments_path(@batch)
  end
end

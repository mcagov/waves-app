class Finance::BatchesController < InternalPagesController
  def index
  end

  def create
    @batch =
      FinancePaymentBatch.create(
        starts_at: Time.now,
        started_by: current_user
      )

    redirect_to new_finance_batch_payment_path(@batch)
  end
end

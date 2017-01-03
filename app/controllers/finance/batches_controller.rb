class Finance::BatchesController < InternalPagesController
  def new
    @finance_payment_batch = FinancePaymentBatch.new
  end
end

class Finance::PaymentsController < InternalPagesController
  def new
    @payment = FinancePayment.new
  end
end

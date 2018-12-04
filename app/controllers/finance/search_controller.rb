class Finance::SearchController < InternalPagesController
  def finance_payments
    @finance_payments = Search.finance_payments(params[:q])
  end
end

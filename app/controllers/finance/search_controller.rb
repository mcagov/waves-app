class Finance::SearchController < InternalPagesController
  def finance_payments
    @filter = filter_params
    @finance_payments = Search.finance_payments(@filter)
    @report = Report.build(:finance_payment_search, @filter)
  end

  protected

  def filter_params
    return default_filter_params unless params[:filter]
    params.require(:filter).permit(:term, :part, :date_start, :date_end)
  end

  def default_filter_params
    { term: params[:q] }
  end
end

class Report::FinancePaymentSearch < Report
  def filter_fields
    [:filter_term, :filter_part, :filter_date_range]
  end

  def date_range_label
    "Fee Receipt Date"
  end
end

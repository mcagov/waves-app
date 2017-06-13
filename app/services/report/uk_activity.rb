class Report::UkActivity < Report
  def title
    "UK Activity"
  end

  def sub_report
    [:uk_activity_by_type]
  end

  def filter_fields
    [:filter_date_range]
  end

  def headings
    %w(Type Total)
  end

  def results
    return [] unless @date_start && @date_end

    report_types.map do |report_type|
      Result.new(
        [report_type[0], submissions_count(report_type[1])],
        activity_report_type: report_type[1])
    end
  end

  private

  # rubocop:disable all
  def report_types
    [
      ["Merchant Flag in", :merchant_flag_in],
      ["Merchant Flag out", :merchant_flag_out],
      ["Flag In", :flag_in],
      ["Flat Out", :flag_out],
      ["Fishing between 15-24m Flag in", :fishing_between_15m_24m_flag_in],
      ["Fishing between 15-24m Flag out", :fishing_between_15m_24m_flag_out],
      ["Fishing over 24m Flag in", :fishing_over_24m_flag_in],
      ["Fishing over 24m Flag out", :fishing_over_24m_flag_out],
      ["Fishing under 15m Flag in", :fishing_under_15m_flag_in],
      ["Fishing under 15m Flag out", :fishing_under_15m_flag_out],
    ]
  end
  # rubocop:enable all

  def submissions_count(uk_activity_report_type)
    submission_scope(uk_activity_report_type).count
  end

  # rubocop:disable all
  def submission_scope(uk_activity_report_type)
    case uk_activity_report_type.to_sym
    when :merchant_flag_in
      Submission.merchant_vessels.flag_in
    when :merchant_flag_out
      Submission.merchant_vessels.flag_out
    when :flag_in
      Submission.flag_in
    when :flag_out
      Submission.flag_out
    when :fishing_between_15m_24m_flag_in
      Submission.fishing_vessels.between_15m_24m.flag_in
    when :fishing_between_15m_24m_flag_out
      Submission.fishing_vessels.between_15m_24m.flag_out
    when :fishing_over_24m_flag_in
      Submission.fishing_vessels.over_24m.flag_in
    when :fishing_over_24m_flag_out
      Submission.fishing_vessels.over_24m.flag_out
    when :fishing_under_15m_flag_in
      Submission.fishing_vessels.under_15m.flag_in
    when :fishing_under_15m_flag_out
      Submission.fishing_vessels.under_15m.flag_out
    end
  end
  # rubocop:enable all
end

class Report::UkActivityReportByType < Report
  def initialize(filters = {})
    super
    @key = @filters[:activity_report_type].to_sym
    @report_type = REPORT_TYPES.find { |r| r[1] == @key }
  end

  def title
    "#{@report_type[0]} (#{@date_start} to #{@date_end})"
  end

  def first_sheet_title
    "UK Activity"
  end

  def headings
    [
      "Vessel Name", "IMO Number", "Official No", "Type", "Length",
      "Gross Tonnage", "Date Actioned", "Reason", "Year Built"
    ]
  end

  # rubocop:disable all
  def results
    submission_scope.map do |submission|
      vessel = Decorators::Vessel.new(submission.registered_vessel)
       Result.new(
        [
          RenderAsLinkToVessel.new(vessel, :name),
          vessel.imo_number,
          vessel.reg_no,
          vessel.vessel_type_description,
          vessel.register_length,
          vessel.gross_tonnage,
          submission.completed_at,
          submission.registration.try(:description),
          vessel.year_of_build
        ])
    end
  end

  def submission_scope
    scope =
      case @key
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
      when :commercial_over_100gt_out
        Submission.commercial.over_100gt.flag_out
      end
    scope.completed
  end

  REPORT_TYPES =
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
      ["Commercial Vessels over 100 GT flag out", :commercial_over_100gt_out]
    ].freeze
  # rubocop:enable all
end

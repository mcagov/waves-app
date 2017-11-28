class Report::TransferInAndOut < Report
  def initialize(filters = {})
    super
    @filter_transfer_type = @filters[:filter_transfer_type] || :transfer_in
  end

  def title
    "Transfers In/Out"
  end

  def filter_fields
    [:filter_date_range, :filter_transfer_type]
  end

  def headings
    ["Name", "IMO Number", "Gross Tonnage", "Transfer date", "Status"]
  end

  def results
    return [] unless @date_start && @date_end

    submissions.map do |submission|
      result_for(submission)
    end
  end

  private

  def submissions
    Submission.completed
  end

  def transfer_status(submission)
    submission.fees.transfers_in.present? ? "Transfer In" : "Transfer Out"
  end

  def result_for(submission)
    vessel = submission.registered_vessel

    Result.new(
      [
        RenderAsLinkToVessel.new(vessel, :name),
        vessel.imo_number,
        vessel.gross_tonnage,
        submission.completed_at,
        transfer_status(submission),
      ]
    )
  end
end

class Report::TransferInAndOut < Report
  def initialize(filters = {})
    super
    @filters[:transfer_type] ||= :transfer_in
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
    query = Submission.completed.includes(:reportable_registered_vessel)
    query = query.includes(:fees)
    query = filter_by_transfer_type(query)
    query = filter_by_completed_at(query)
    query.order("vessels.name")
  end

  def result_for(submission)
    vessel = submission.registered_vessel

    Result.new(
      [
        RenderAsLinkToVessel.new(vessel, :name),
        vessel.imo_number,
        vessel.gross_tonnage,
        submission.completed_at,
        @transfer_type.to_s.titleize,
      ]
    )
  end

  def filter_by_transfer_type(scoped_query)
    transfer_type_key =
      if @filter_transfer_type == :transfer_in
        :transfer_from_bdt
      else
        :transfer_to_bdt
      end

    scoped_query.where("fees.task_variant = ?", transfer_type_key)
  end

  def filter_by_completed_at(scoped_query)
    if @date_start.present?
      scoped_query = scoped_query.where("completed_at >= ?", @date_start)
    end

    if @date_end.present?
      scoped_query = scoped_query.where("completed_at <= ?", @date_end)
    end

    scoped_query
  end
end

class Report::TransferOut < Report
  def title
    "Transfers Out"
  end

  def filter_fields
    [:filter_part, :filter_date_range]
  end

  def date_range_label
    "Date Registration Closed"
  end

  def headings
    ["Name", "Part", "IMO Number", "Gross Tonnage", "Date Registration Closed"]
  end

  def results
    return [] unless @date_start && @date_end
    @pagination_collection = paginate(vessels)
    @pagination_collection.map do |vessel|
      Result.new(
        [
          RenderAsLinkToVessel.new(vessel, :name),
          vessel.part.to_s.humanize,
          vessel.imo_number, vessel.gross_tonnage,
          vessel.current_registration.try(:closed_at)])
    end
  end

  private

  def vessels
    Register::Vessel
      .joins(:current_registration)
      .in_part(@part)
      .where("registrations.closed_at >= ? ", @date_start)
      .where("registrations.closed_at <= ? ", @date_end)
      .order("registrations.closed_at desc")
      .all
  end
end

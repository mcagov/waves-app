class Report::TransferIn < Report
  def title
    "Transfers In"
  end

  def filter_fields
    [:filter_part, :filter_date_range]
  end

  def date_range_label
    "Date Registered"
  end

  def headings
    ["Name", "Part", "IMO Number", "Gross Tonnage", "Date Registered"]
  end

  def results
    return [] unless @date_start && @date_end
    vessels.map do |vessel|
      Result.new(
        [
          RenderAsLinkToVessel.new(vessel, :name),
          vessel.part.to_s.humanize,
          vessel.imo_number,
          vessel.gross_tonnage,
          vessel.first_registration.try(:registered_at)])
    end
  end

  private

  def vessels
    Register::Vessel
      .joins(:first_registration)
      .in_part(@part)
      .where("registrations.registered_at >= ? ", @date_start)
      .where("registrations.registered_at <= ? ", @date_end)
      .order("registrations.registered_at desc")
      .all
  end
end

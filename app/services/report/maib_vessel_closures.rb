class Report::MaibVesselClosures < Report
  def title
    "Fishing Vessel Closures"
  end

  def headings
    [
      "Vessel Name", "PLN", "Official Number", "Registered Length",
      "Gross Tonnage", "Year of Build", "Date of Closure", "Closure Narrative"
    ]
  end

  def results
    ret =
      registrations.map do |registration|
        assign_result(registration)
      end

    ret.sort_by { |r| [r.data_elements[1], r.data_elements[0]] }
  end

  private

  def registrations
    Registration
      .fishing_vessels
      .includes(:submissions)
      .where("closed_at >= ?", @date_start)
      .where("closed_at <= ?", @date_end)
  end

  def load_vessel(registration)
    Decorators::Vessel.new(registration.vessel)
  end

  def assign_result(registration) # rubocop:disable Metrics/MethodLength
    vessel = load_vessel(registration)
    Result.new(
      [
        vessel.name,
        vessel.pln,
        vessel.reg_no,
        vessel.register_length,
        vessel.gross_tonnage,
        vessel.year_of_build,
        registration.closed_at,
        registration.description,
      ])
  end
end

class Report::MaibQuarterly < Report
  def title
    "Under 12m"
  end

  def second_sheet_title
    "12m and over"
  end

  def headings
    [
      "Name", "PLN", "Official No", "Registered Length", "Overall Length",
      "Depth", "Breadth", "Gross Tonnage", "Net Tonnage", "Power (kW)",
      "Construction", "Year Built", "Owner(s) Name, Address & Shareholding",
      "Registration Status", "Transaction Type", "Date of Transaction"
    ]
  end

  def results # rubocop:disable Metrics/MethodLength
    Registration.includes(:submissions).all.map do |registration|
      vessel = load_vessel(registration)

      Result.new(
        [
          vessel.name,
          vessel.pln,
          vessel.reg_no,
          vessel.register_length,
          vessel.length_overall,
          vessel.depth,
          vessel.breadth,
          vessel.gross_tonnage,
          vessel.net_tonnage,
          Engine.total_mcep_for(registration),
          vessel.hull_construction_material,
          vessel.year_of_build,
          registration.owner_name_address_shareholding,
          (registration.closed_at? ? "Closed" : "Registered"),
          transaction_type(registration),
          registration.created_at,
        ])
    end.sort_by { |r| [r.data_elements[1], r.data_elements[0]] }
  end

  private

  def load_vessel(registration)
    Decorators::Vessel.new(registration.vessel)
  end

  def transaction_type(registration)
    return "" if registration.submissions.empty?
    Task.new(registration.submissions.first.task).description
  end
end

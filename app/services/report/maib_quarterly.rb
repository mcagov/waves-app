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
end

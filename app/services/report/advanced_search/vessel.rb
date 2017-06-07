class Report::AdvancedSearch::Vessel < Report::AdvancedSearch::Criteria
  def attributes
    [
      [:name, "Name", :string],
      [:hin, "HIN", :string],
      [:gross_tonnage, "Gross Tonnage", :integer],
    ]
  end
end

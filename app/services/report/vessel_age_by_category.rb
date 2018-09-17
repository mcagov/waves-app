class Report::VesselAgeByCategory < Report
  def initialize(filters = {})
    super
    @vessel_category = @filters[:vessel_category]
  end

  def title
    "Vessel Age: #{@vessel_category}"
  end

  def first_sheet_title
    "Vessel Age"
  end

  def headings
    [
      "Vessel Name", "Part", "IMO No", "Official No", "Age", "Gross Tonnage",
      "Year of Build"
    ]
  end

  def results
    @pagination_collection = vessels
    @pagination_collection.map do |vessel|
      assign_result(vessel)
    end
  end

  private

  def vessels
    query =
      Register::Vessel.select(
        "(coalesce(EXTRACT('year' FROM now()::DATE ) "\
        "- year_of_build, 0)) age, *")

    query = query.where(vessel_category: @vessel_category)
    query = filter_by_part(query)
    query = query.order(:name)
    paginate(query)
  end

  def assign_result(vessel)
    data_elements = [
      RenderAsLinkToVessel.new(vessel, :name),
      Activity.new(vessel.part),
      vessel.imo_number,
      vessel.reg_no,
      vessel.age.to_f.round(2),
      vessel.gross_tonnage,
      vessel.year_of_build]

    Result.new(data_elements)
  end
end

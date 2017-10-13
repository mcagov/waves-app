class Report::VesselAgeByType < Report
  def initialize(filters = {})
    super
    @vessel_type = @filters[:vessel_type]
  end

  def title
    "Vessel Age: #{@vessel_type}"
  end

  def first_sheet_title
    "Vessel Age"
  end

  def headings
    [
      "Vessel Name", "Part", "IMO No", "Official No", "Age", "Gross Tonnage"
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
        "(coalesce(now()::DATE - keel_laying_date::DATE, "\
        "0)::FLOAT / 365) age, *")

    query = query.where(vessel_type: @vessel_type)
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
      vessel.gross_tonnage]

    Result.new(data_elements)
  end
end

class Report::AdvancedSearch < Report
  def initialize(filters = {})
    super
    @vessel_criteria = VesselCriteria.new(@filters)
  end

  def title
    "Advanced Search"
  end

  def filter_fields
    [:filter_advanced_search]
  end

  def sections
    {
      vessel: @vessel_criteria.section_attributes,
    }
  end

  def headings
    @vessel_criteria.headings
  end

  def results
    @pagination_collection = vessels
    @pagination_collection.map do |vessel|
      Result.new(
        @vessel_criteria.column_attributes.map { |col| vessel.send(col) })
    end
  end

  private

  def vessels
    query = Register::Vessel
    query = filter_by_part(query)
    query = filter_by_vessel_details(query)
    query = query.order(:name)
    paginate(query)
  end

  def filter_by_vessel_details(query)
    # to do: query builder
    query
  end
end

class Report::AdvancedSearch < Report
  def initialize(filters = {})
    @vessel_attributes = filters[:vessel_attributes] || [:name, :gross_tonnage]
    super
  end

  def title
    "Advanced Search"
  end

  def filter_fields
    [:filter_advanced_search]
  end

  def filter_attributes
    {
      vessel: Vessel.new(@vessel_attributes).selected_attributes.take(20),
    }
  end

  def results
    @pagination_collection = vessels
    @pagination_collection.map do |vessel|
      Result.new(
        # to do: results attributes are built by the user
        [
          vessel.name,
          vessel.hin,
        ])
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

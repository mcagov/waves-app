class Report::AdvancedSearch < Report
  def title
    "Advanced Search"
  end

  def filter_fields
    [:filter_advanced_search]
  end

  SearchAttr = Struct.new(:name, :key, :dataype)

  def filter_attributes
    # to do: filter attributes are built by the user
    {
      vessel:
        [
          Report::AdvancedSearch::SearchAttr.new("Name", :name, :string),
          Report::AdvancedSearch::SearchAttr.new("HIN", :hin, :string),
          Report::AdvancedSearch::SearchAttr.new("Gross Tonnage", :gross_tonnage, :integer),
        ],
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

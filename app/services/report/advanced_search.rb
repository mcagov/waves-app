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
    query = filter_by_vessel_details(query)
    query = query.order(:name)
    paginate(query)
  end

  def filter_by_vessel_details(query)
    @filters[:vessel].each_pair do |k, v|
      next if v[:value].blank?
      query = query.where(build_query(v[:operator], k, v[:value]))
    end
    query
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def build_query(operator, column, value)
    case (operator || "").to_sym
    when :includes then ["#{column} LIKE ?", "%#{value}%"]
    when :excludes then ["#{column} NOT like ?", "%#{value}%"]
    when :equals then ["#{column} = ?", value.to_f]
    when :greater_than then ["#{column} > ?", value.to_f]
    when :less_than then ["#{column} < ?", value.to_f]
    end
  end
end

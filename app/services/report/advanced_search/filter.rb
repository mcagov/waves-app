class Report::AdvancedSearch::Filter
  def initialize(section, criteria, filter = {})
    @section_key = section.key
    @criteria_key = criteria.key
    @filter = filter
  end

  def criteria_filter
    if @filter[@section_key] && @filter[@section_key][@criteria_key]
      @filter[@section_key][@criteria_key]
    else
      {}
    end
  end
end

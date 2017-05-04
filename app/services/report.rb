class Report
  class << self
    def build(template, filters = {})
      case template.to_sym
      when :staff_performance
        Report::StaffPerformance.new(filters)
      end
    end
  end

  def initialize(filters = {})
    @filters = filters
  end

  def apply_filters(scoped_query)
    @filters[:part] ? scoped_query.in_part(@filters[:part]) : scoped_query
  end
end

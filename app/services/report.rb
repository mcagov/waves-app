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
    @part = filters[:part]
  end

  def apply_scoped_filters(scoped_query)
    @part.present? ? scoped_query.in_part(@part) : scoped_query
  end
end

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
    @part = filters[:part]
    @date_start = parse_date_start
    @date_end = parse_date_end
  end

  Result = Struct.new(:data_elements, :subreport)

  def filter_by_part(scoped_query)
    @part.present? ? scoped_query.in_part(@part) : scoped_query
  end

  def filter_by_completed_at(scoped_query)
    if @date_start.present?
      scoped_query = scoped_query.where("completed_at > ?", @date_start)
    end

    if @date_end.present?
      scoped_query = scoped_query.where("completed_at < ?", @date_end)
    end

    scoped_query
  end

  private

  def parse_date_start
    if @filters[:date_start].present?
      @filters[:date_start].to_date.at_beginning_of_day
    end
  end

  def parse_date_end
    @filters[:date_end].to_date.at_end_of_day if @filters[:date_end].present?
  end
end

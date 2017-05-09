class Report
  class << self
    def build(template, filters = {})
      case template.to_sym
      when :staff_performance
        Report::StaffPerformance.new(filters)
      when :staff_performance_by_task
        Report::StaffPerformanceByTask.new(filters)
      when :vessel_registration_status
        Report::VesselRegistrationStatus.new(filters)
      end
    end
  end

  def initialize(filters = {})
    @filters = filters
    @part = filters[:part]
    @date_start = parse_date_start
    @date_end = parse_date_end
    @task = filters[:task] || :new_registration
  end

  Result = Struct.new(:data_elements, :sub_report_filters)

  def filter_fields
    []
  end

  def sub_report
  end

  def headings
    []
  end

  def results
    []
  end

  def date_range_label
    "Date Range"
  end

  protected

  def filter_by_part(scoped_query)
    @part.present? ? scoped_query.in_part(@part) : scoped_query
  end

  def filter_by_received_at(scoped_query)
    if @date_start.present?
      scoped_query = scoped_query.where("received_at > ?", @date_start)
    end

    if @date_end.present?
      scoped_query = scoped_query.where("received_at < ?", @date_end)
    end

    scoped_query
  end

  def filter_by_registered_until(scoped_query)
    if @date_start.present?
      scoped_query =
        scoped_query.where("registrations.registered_until > ?", @date_start)
    end

    if @date_end.present?
      scoped_query =
        scoped_query.where("registrations.registered_until < ?", @date_end)
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

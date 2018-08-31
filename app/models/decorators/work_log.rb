class Decorators::WorkLog < SimpleDelegator
  def initialize(work_log)
    @work_log = work_log
    super
  end

  def title
    "#{task.service}: #{task.ref_no}"
  end

  def part_of_registry
    Activity.new(part).to_s
  end

  def date_recorded
    created_at.in_time_zone.to_s(:date_time)
  end
end

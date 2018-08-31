class Decorators::WorkLog < SimpleDelegator
  def initialize(work_log)
    @work_log = work_log
    super
  end

  def loggable_title
    "#{loggable.service}: #{loggable.ref_no}" if task
  end

  def part_of_registry
    Activity.new(part).to_s
  end

  def date_recorded
    created_at.in_time_zone.to_s(:date_time)
  end

  private

  def task
    loggable if loggable.is_a?(Submission::Task)
  end
end

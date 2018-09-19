class StaffPerformanceLog < ApplicationRecord
  belongs_to :task, class_name: "Submission::Task"
  belongs_to :actioned_by, class_name: "User"

  enum activity: [:cancelled, :referred, :completed]
  enum service_level: ServiceLevel::SERVICE_LEVEL_TYPES.map(&:last)

  scope :within_standard, -> { where(within_standard: true) }
  scope :standard_missed, -> { where(within_standard: false) }

  scope :in_part, ->(part) { where(part: part) if part }

  before_create :set_service_standard

  def set_service_standard
    self.within_standard = (Time.zone.now < target_date.to_time.at_end_of_day)
  end

  class << self
    def record(task, activity, actioned_by)
      create(
        task: task,
        activity: activity,
        service_level: task.service_level,
        target_date: task.target_date,
        part: task.part,
        actioned_by: actioned_by)
    end
  end
end

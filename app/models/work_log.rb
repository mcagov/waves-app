class WorkLog < ApplicationRecord
  belongs_to :task, class_name: "Submission::Task"
  belongs_to :actioned_by, class_name: "User"

  validates :task_id, presence: true
  validates :description, presence: true
  validates :actioned_by_id, presence: true

  scope :in_part, (lambda do |part|
    where(part: part) if part
  end)

  scope :actioned_by, (lambda do |actioned_by_id|
    where(actioned_by_id: actioned_by_id) if actioned_by_id
  end)

  scope :date_start, (lambda do |date_start|
    if date_start
      where("created_at > ?", date_start.to_date.at_beginning_of_day)
    end
  end)

  scope :date_end, (lambda do |date_end|
    where("created_at < ?", date_end.to_date.at_end_of_day) if date_end
  end)

  class << self
    def latest(task, description)
      where(task: task)
        .where(description: description)
        .order(created_at: :desc)
        .first
    end
  end
end

class WorkLog < ApplicationRecord
  belongs_to :loggable, polymorphic: true

  belongs_to :actioned_by, class_name: "User"

  scope :in_part, ->(part) { where(part: part.to_sym) }

  validates :loggable_id, presence: true
  validates :description, presence: true
  validates :actioned_by_id, presence: true

  scope :in_part, (lambda do |part|
    where(part: part) if part
  end)

  scope :actioned_by, (lambda do |actioned_by_id|
    where(actioned_by_id: actioned_by_id) if actioned_by_id
  end)

  scope :date_start, (lambda do |date_start|
    where("created_at >= ?", date_start) if date_start
  end)

  scope :date_end, (lambda do |date_end|
    where("created_at <= ?", date_end) if date_end
  end)

  class << self
    def latest(loggable, description)
      where(loggable: loggable)
        .where(description: description)
        .order(created_at: :desc)
        .first
    end
  end
end

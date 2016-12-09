class WorkLog < ApplicationRecord
  belongs_to :submission
  belongs_to :actioned_by, class_name: "User"

  scope :in_part, ->(part) { where(part: part.to_sym) }

  validates :submission_id, presence: true
  validates :actioned_by_id, presence: true
  validates :part, presence: true

  class << self
    def activities_for(_loggable)
      []
    end
  end
end
class WorkLog < ApplicationRecord
  belongs_to :loggable, polymorphic: true

  belongs_to :actioned_by, class_name: "User"

  scope :in_part, ->(part) { where(part: part.to_sym) }

  validates :loggable_id, presence: true
  validates :description, presence: true
  validates :actioned_by_id, presence: true
  validates :part, presence: true

  class << self
    def latest(loggable, description)
      where(loggable: loggable)
        .where(description: description)
        .order(created_at: :desc)
        .first
    end
  end
end

class WorkLog < ApplicationRecord
  belongs_to :submission
  belongs_to :actioned_by, class_name: "User"

  class << self
    def activities_for(_loggable)
      []
    end
  end
end

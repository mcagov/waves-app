class Notification < ApplicationRecord
  self.table_name = "notifications"

  belongs_to :submission
end

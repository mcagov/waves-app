class Payment < ApplicationRecord
  validates :submission_id, presence: true
end

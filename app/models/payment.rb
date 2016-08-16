class Payment < ApplicationRecord
  validates :registration_id, presence: true
end

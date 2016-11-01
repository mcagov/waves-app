class Payment < ApplicationRecord
  belongs_to :submission, touch: true
  belongs_to :remittance, polymorphic: true

  validates :submission, presence: true
end

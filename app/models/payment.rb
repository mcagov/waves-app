class Payment < ApplicationRecord
  belongs_to :submission

  belongs_to :remittance, polymorphic: true

  after_create :move_to_unassigned

  validates :submission, presence: true

  private

  def move_to_unassigned
    submission.unassigned!
  end
end

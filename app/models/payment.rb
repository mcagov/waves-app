class Payment < ApplicationRecord
  belongs_to :submission

  belongs_to :remittance, polymorphic: true

  after_create :mark_submission_as_paid

  validates :submission, presence: true

  private

  def mark_submission_as_paid
    submission.paid!
  end
end

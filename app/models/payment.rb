class Payment < ApplicationRecord
  belongs_to :submission

  belongs_to :remittance, polymorphic: true

  after_create :mark_submission_as_paid

  validates :submission, presence: true

  PAYMENT_TYPES = [
    ["Bacs", :bacs],
    ["Cash", :cash],
    ["Cheque", :cheque],
    ["Client Account", :client_account],
    ["Credit/Debit Card", :card],
    ["Postal Order", :postal_order],
  ].freeze

  private

  def mark_submission_as_paid
    submission.paid!
  end
end

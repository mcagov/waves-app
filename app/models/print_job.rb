class PrintJob < ApplicationRecord
  belongs_to :submission
  belongs_to :printable, polymorphic: true
  belongs_to :printing_by, class_name: "User"
  belongs_to :printed_by, class_name: "User"

  validates :part, presence: true
  validates :template, presence: true
  validates :printable, presence: true

  scope :in_part, ->(part) { where(part: part.to_sym) }

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :unprinted
    state :printing
    state :printed

    event :printing, timestamp: true do
      transitions to: :printing, from: [:unprinted, :printing],
                  on_transition: :log_printing_by
    end

    event :printed, timestamp: true do
      transitions to: :printed, from: [:printing, :printed],
                  on_transition: :log_printed_by
    end
  end

  private

  def log_printing_by(printing_by)
    update_attribute(:printing_by, printing_by)
  end

  def log_printed_by(printed_by)
    update_attribute(:printed_by, printed_by)
  end
end

class PrintJob < ApplicationRecord
  belongs_to :printable, polymorphic: true
  belongs_to :printed_by, class_name: "User"

  validates :part, presence: true
  validates :template, presence: true

  scope :in_part, ->(part) { where(part: part.to_sym) }
  scope :unprinted, -> { where(printed_at: nil) }
end

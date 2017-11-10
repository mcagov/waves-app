class Note < ApplicationRecord
  belongs_to :noteable, polymorphic: true
  belongs_to :actioned_by, class_name: "User"

  has_many :assets, as: :owner, dependent: :destroy
  accepts_nested_attributes_for :assets

  delegate :part, to: :noteable, allow_nil: true

  class << self
    def build(counter = 1)
      # rubocop:disable Style/RedundantSelf
      note = self.new
      counter.times { note.assets.build }
      note
    end
  end

  def asset
    assets.first
  end
end

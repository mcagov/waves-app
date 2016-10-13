class Note < ApplicationRecord
  belongs_to :noteable, polymorphic: true
  belongs_to :actioned_by, class_name: "User"

  has_many :assets, as: :owner
  accepts_nested_attributes_for :assets

  class << self
    def build(counter = 1)
      note = Note.new
      counter.times { note.assets.build }
      note
    end
  end
end

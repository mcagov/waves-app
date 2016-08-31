class Note < ApplicationRecord
  belongs_to :noteable, polymorphic: true
  belongs_to :actioned_by, class_name: "User"
end

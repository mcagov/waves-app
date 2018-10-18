class Asset < ApplicationRecord
  belongs_to :owner, polymorphic: true
  belongs_to :removed_by, class_name: "User"

  has_attached_file :file, validate_media_type: false
  do_not_validate_attachment_file_type :file
end

class Asset < ApplicationRecord
  has_attached_file :file, validate_media_type: false
  do_not_validate_attachment_file_type :file
end

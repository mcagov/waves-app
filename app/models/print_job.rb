class PrintJob < ApplicationRecord
  belongs_to :printable, polymorphic: true
  belongs_to :printed_by, class_name: "User"
end

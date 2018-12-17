class Mortgagee < Customer
  belongs_to :mortgage,
             inverse_of: :mortgagors,
             foreign_key: :parent_id,
             foreign_type: :parent_id

  delegate :vessel, to: :parent
  delegate :part, to: :parent

  has_many :mortgagee_reminder_letters, as: :printable, class_name: "PrintJob"
end

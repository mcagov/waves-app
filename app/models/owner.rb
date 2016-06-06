class Owner < ActiveRecord::Base
  ALLOWED_NATIONALITIES = [
    "UK"
  ].freeze

  has_many :owner_addresses
  has_many :addresses, through: :owner_addresses

  has_many :owner_vessels
  has_many :vessels, through: :owner_vessels

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates(
    :nationality,
    presence: true,
    format: { with: /\A[A-Z]{2}\z/ },
    inclusion: { in: ALLOWED_NATIONALITIES }
  )

  validates_email_format_of :email, presence: true

  validates :mobile_number, presence: true
end

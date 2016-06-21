class Owner < ActiveRecord::Base
  ALLOWED_NATIONALITIES = [
    "GB"
  ].freeze

  SUGGESTED_TITLES = [
    "Mr",
    "Mrs",
    "Miss",
    "Ms",
    "Doctor",
    "Reverant"
  ].freeze

  has_many :owner_vessels
  has_many :vessels, through: :owner_vessels

  belongs_to :address
  accepts_nested_attributes_for :address

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates(
    :nationality,
    presence: true,
    format: { with: /\A[A-Z]{2}\z/ },
    inclusion: { in: ALLOWED_NATIONALITIES }
  )

  validates_email_format_of :email

  validates :phone_number, presence: true

  def full_name_with_title
    "#{title} #{first_name} #{last_name}"
  end
end

class Vessel < ActiveRecord::Base
  has_many :owner_vessels
  has_many :owners, through: :owner_vessels

  has_many :vessel_registrations
  has_many :registrations, through: :vessel_registrations

  has_many :register_vessels
  has_many :registers, through: :register_vessels

  belongs_to :vessel_type

  validates :name, presence: true

  validates(
    :hin,
    format: { with: /\A[A-Z]{2}\-[0-9A-Z]{12}\z/ },
    allow_blank: true
  )
  validate :hin_must_begin_with_a_valid_country_code

  validates(
    :length_in_centimeters,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      less_than_or_equal_to: 2399
    }
  )

  validates(
    :number_of_hulls,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      less_than_or_equal_to: 6
    }
  )

  validates :vessel_type_id, presence: true, if: "vessel_type_other.blank?"
  validates :vessel_type_id, absence: true, if: "vessel_type_other.present?"

  validates :vessel_type_other, presence: true, if: "vessel_type.blank?"
  validates :vessel_type_other, absence: true, if: "vessel_type.present?"

  validates(
    :mmsi_number,
    presence: true,
    uniqueness: true,
    numericality: { only_integer: true },
    format: { with: /\A(232|233|234|235)\d{6}\z/ }
  )

  validates(
    :radio_call_sign,
    presence: true,
    format: { with: /\A[a-zA-Z]\d{4,5}\z/ }
  )

  private

  def hin_must_begin_with_a_valid_country_code
    return if hin.blank? || ISO3166::Data.codes.include?(hin[0..1])

    message = I18n.t("activerecord.errors.models.vessel.attributes.hin.invalid")
    errors.add(:hin, message)
  end
end

class Vessel < ApplicationRecord
  include VesselValidations

  has_many :owner_vessels
  has_many :owners, through: :owner_vessels

  has_many :submissions

  has_many :register_vessels
  has_many :registers, through: :register_vessels

  validates_uniqueness_of :mmsi_number

  def correspondent
    owners.first
  end

  private

  def hin_must_begin_with_a_valid_country_code
    return if hin.blank? || ISO3166::Data.codes.include?(hin[0..1])

    message = I18n.t("activerecord.errors.models.vessel.attributes.hin.invalid")
    errors.add(:hin, message)
  end
end

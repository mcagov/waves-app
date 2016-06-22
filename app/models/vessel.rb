class Vessel < ActiveRecord::Base
  include VesselValidations

  has_many :owner_vessels
  has_many :owners, through: :owner_vessels

  has_many :registrations

  has_many :register_vessels
  has_many :registers, through: :register_vessels

  belongs_to :vessel_type

  private

  def hin_must_begin_with_a_valid_country_code
    return if hin.blank? || ISO3166::Data.codes.include?(hin[0..1])

    message = I18n.t("activerecord.errors.models.vessel.attributes.hin.invalid")
    errors.add(:hin, message)
  end
end

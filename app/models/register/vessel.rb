class Register::Vessel < ApplicationRecord
  include VesselValidations
  has_many :registered_owners, class_name: "Register::Owner"

  private

  def hin_must_begin_with_a_valid_country_code
    return if hin.blank? || ISO3166::Data.codes.include?(hin[0..1])

    message = I18n.t("activerecord.errors.models.vessel.attributes.hin.invalid")
    errors.add(:hin, message)
  end
end

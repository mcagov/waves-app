module VesselValidations
  extend ActiveSupport::Concern

  included do
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
        less_than_or_equal_to: 2399,
      }
    )

    validates(
      :number_of_hulls,
      presence: true,
      numericality: {
        only_integer: true,
        greater_than: 0,
        less_than_or_equal_to: 6,
      }
    )

    validates :vessel_type_id, presence: true, if: "vessel_type_other.blank?"
    validates :vessel_type_id, absence: true, if: "vessel_type_other.present?"

    validates :vessel_type_other, presence: true, if: "vessel_type_id.blank?"
    validates :vessel_type_other, absence: true, if: "vessel_type_id.present?"

    validates(
      :mmsi_number,
      presence: true,
      numericality: { only_integer: true },
      format: { with: /\A(232|233|234|235)\d{6}\z/ }
    )

    validates(
      :radio_call_sign,
      presence: true,
      length: { minimum: 6, maximum: 7 },
      format: { with: /\A[0-9A-Z]{6,7}\z/ }
    )
  end
end

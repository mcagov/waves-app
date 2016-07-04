module AddressValidations
  extend ActiveSupport::Concern

  included do
    validates :address_1, presence: true
    validates :town, presence: true
    validates :postcode, presence: true

    validates(
      :country,
      presence: true,
      format: { with: /\A[A-Z]{2}\z/ },
      inclusion: { in: ISO3166::Data.codes }
    )
  end
end

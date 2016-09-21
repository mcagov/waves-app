module Address
  extend ActiveSupport::Concern

  included do
    attr_accessor(
      :name,
      :address_1,
      :address_2,
      :address_3,
      :town,
      :postcode,
      :country
    )

    def inline_address
      [
        address_1,
        address_2,
        address_3,
        town,
        country,
        postcode,
      ].compact.reject(&:empty?).join(", ")
    end
  end
end

module OwnerValidations
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true

    validates(
      :nationality,
      presence: true,
      format: { with: /\A[A-Z]{2}\z/ },
      inclusion: { in: Owner::ALLOWED_NATIONALITIES }
    )

    validates_email_format_of :email

    validates :phone_number, presence: true

    # FIXME: title!
  end
end

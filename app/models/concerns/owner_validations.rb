module OwnerValidations
  extend ActiveSupport::Concern

  included do
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

    validates_presence_of :title,
                        unless: proc { |oi| oi.title_other.present? }

    validates_presence_of :title_other,
                        unless: proc { |oi| oi.title.present? }
  end
end

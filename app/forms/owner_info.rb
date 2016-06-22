class OwnerInfo
  include ActiveModel::Model

  attr_accessor(
    :title,
    :title_other,
    :first_name,
    :last_name,
    :nationality,
    # --- address
    :address_1,
    :address_2,
    :address_3,
    :town,
    :county,
    :postcode,
    :country,
    :email,
    :phone_number
  )

  validates_presence_of :first_name,
                        :last_name,
                        :nationality,
                        :address_1,
                        :town,
                        :postcode,
                        :country,
                        :email,
                        :phone_number

  validates_presence_of :title,
                        unless: proc { |oi| oi.title_other.present? }

  validates_presence_of :title_other,
                        unless: proc { |oi| oi.title.present? }

  def full_name_with_title
    "#{title} #{first_name} #{last_name}"
  end
end

class ClientSession < ApplicationRecord
  belongs_to :customer, required: true, class_name: "Customer"
  belongs_to :registered_vessel,
             foreign_key: :vessel_reg_no,
             primary_key: :reg_no,
             class_name: "Register::Vessel",
             required: true

  validates :vessel_reg_no, presence: true
  validates :customer_id, presence: true
  validates :external_session_key, presence: true
  validates :access_code, presence: true, length: { is: 6 }

  before_validation(on: :create) do
    self.access_code = rand(100000..999999)
  end

  def email=(val)
    return unless registered_vessel
    self.customer = registered_vessel.customers.find_by(email: val)
  end

  after_create do
    SmsProvider.send_access_code(customer, access_code)
  end

  def obfuscated_recipient_phone_numbers
    vessel.owners.map do |owner|
      "********#{owner.phone_number.last(3)}"
    end
  end
end

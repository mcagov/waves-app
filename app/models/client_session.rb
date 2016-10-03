class ClientSession < ApplicationRecord
  belongs_to :vessel,
             foreign_key: :vessel_reg_no,
             primary_key: :reg_no,
             class_name: "Register::Vessel",
             required: true

  validates :vessel_reg_no, presence: true
  validates :external_session_key, presence: true
  validates :access_code, presence: true, length: { is: 6 }

  before_validation(on: :create) do
    self.access_code = rand(100000..999999)
  end

  after_create do
    SmsProvider.send_access_code(vessel.owners, access_code)
  end

  def obfuscated_recipient_phone_numbers
    vessel.owners.map do |owner|
      "********#{owner.phone_number.last(3)}"
    end
  end
end

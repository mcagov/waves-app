class ClientSession < ApplicationRecord
  belongs_to :vessel,
             foreign_key: :vessel_reg_no,
             primary_key: :reg_no,
             class_name: "Register::Vessel",
             required: true

  validates :vessel_reg_no, presence: true
  validates :external_session_key, presence: true
  validates :otp, presence: true, length: { is: 6 }

  before_validation(on: :create) do
    self.otp = rand(10000..999999)
  end

  def obfuscated_recipient_phone_numbers
    vessel.owners.map do |owner|
      "######{owner.phone_number.last(3)}"
    end
  end
end

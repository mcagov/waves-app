class ClientSession < ApplicationRecord
  belongs_to :vessel,
             foreign_key: :vessel_reg_no,
             primary_key: :reg_no,
             class_name: "Register::Vessel",
             required: true

  validates :vessel_reg_no, presence: true
  validates :external_session_key, presence: true
  validates :otp, presence: true, length: { is: 6 }

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :unused, enter: :init_client_session
    state :used
  end

  def obfuscated_recipient_phone_numbers
    vessel.owners.map do |owner|
      "######{owner.phone_number.last(3)}"
    end
  end

  private

  def init_client_session
    self.otp = rand(10000..999999)

    return unless valid?
    SmsProvider.send_otp(vessel.owners, otp)
  end
end

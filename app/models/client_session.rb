class ClientSession < ApplicationRecord
  belongs_to :vessel,
             foreign_key: :vessel_reg_no,
             primary_key: :reg_no,
             class_name: "Register::Vessel"

  validates :vessel_reg_no, presence: true
  validates :external_session_key, presence: true
  validates :otp, presence: true, length: { is: 6 }

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :unused, enter: :init_client_session
    state :used
  end

  private

  def init_client_session
    self.otp = rand(10000..999999)
  end
end

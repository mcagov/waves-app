class ChangeOtpToAccessCode < ActiveRecord::Migration[5.0]
  def change
    rename_column :client_sessions, :otp, :access_code
  end
end

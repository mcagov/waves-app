class AddRegistrationTypeIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :vessels, :registration_type
  end
end

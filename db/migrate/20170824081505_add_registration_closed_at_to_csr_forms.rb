class AddRegistrationClosedAtToCsrForms < ActiveRecord::Migration[5.1]
  def change
    add_column :csr_forms, :registration_closed_at, :datetime
  end
end

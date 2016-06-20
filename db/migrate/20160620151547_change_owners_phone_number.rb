class ChangeOwnersPhoneNumber < ActiveRecord::Migration
  def up
    remove_column :owners, :phone_number
    rename_column :owners, :mobile_number, :phone_number
  end

  def down
    rename_column :owners, :phone_number, :mobile_number
    add_column :owners, :phone_number, :string
  end
end

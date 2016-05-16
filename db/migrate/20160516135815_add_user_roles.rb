class AddUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.integer :user_id, references: :users
      t.integer :role_id, references: :roles

      t.timestamps null: false
    end
  end
end

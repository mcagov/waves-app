class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :ldap_id, null: false

      t.timestamps null: false
    end
  end
end

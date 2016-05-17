class AddAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_1, null: false
      t.string :address_2
      t.string :address_3
      t.string :town, null: false
      t.string :county
      t.string :postcode, null: false

      t.timestamps null: false
    end
  end
end

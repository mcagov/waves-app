class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.uuid :vessel_id, index: true
      t.string :type, index: true
      t.string :email, index: true
      t.string :name
      t.string :nationality
      t.string :email
      t.string :phone_number
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :town
      t.string :county
      t.string :postcode
      t.string :country

      t.timestamps
    end
  end
end

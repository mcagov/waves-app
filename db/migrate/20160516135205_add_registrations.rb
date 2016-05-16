class AddRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :ip_country, null: false
      t.string :card_country, null: false
      t.string :browser, null: false
      t.string :payment_id, null: false
      t.string :receipt_id
      t.string :status, null: false
      t.datetime :due_date, null: false
      t.boolean :is_urgent, null: false

      t.timestamps null: false
    end
  end
end

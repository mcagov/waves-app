class AddRegistrations < ActiveRecord::Migration
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :registrations do |t|
      t.string :ip_country
      t.string :card_country
      t.string :browser, null: false
      t.string :payment_id
      t.string :receipt_id
      t.string :status, null: false
      t.datetime :due_date
      t.boolean :is_urgent

      t.timestamps null: false
    end
  end
  # rubocop:enable Metrics/MethodLength
end

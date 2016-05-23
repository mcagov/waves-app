class AddOwners < ActiveRecord::Migration
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :owners do |t|
      t.string :title, null: false
      t.string :forename, null: false
      t.string :surname, null: false
      t.string :surname, null: false
      t.string :nationality, null: false
      t.string :email, null: false
      t.string :phone_number
      t.string :mobile_number, null: false

      t.timestamps null: false
    end
  end
  # rubocop:enable Metrics/MethodLength
end

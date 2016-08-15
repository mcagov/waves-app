class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.belongs_to :registration
      t.json :changeset
      t.timestamps
    end
  end
end

class RemoveCountries < ActiveRecord::Migration[5.0]
  def change
    drop_table :countries do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end

class AddRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end

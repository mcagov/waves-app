class AddVessels < ActiveRecord::Migration
  def change
    create_table :vessels do |t|
      t.string :name, null: false
      t.string :hin
      t.string :make_and_model
      t.integer :length_in_centimeters, null: false
      t.integer :number_of_hulls, null: false

      t.integer :vessel_type_id, references: :vessel_types

      t.timestamps null: false
    end
  end
end

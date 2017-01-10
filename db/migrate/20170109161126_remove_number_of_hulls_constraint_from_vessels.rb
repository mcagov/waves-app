class RemoveNumberOfHullsConstraintFromVessels < ActiveRecord::Migration[5.0]
  def up
    change_column :vessels, :number_of_hulls, :string, null: true
  end

  def down
  end
end

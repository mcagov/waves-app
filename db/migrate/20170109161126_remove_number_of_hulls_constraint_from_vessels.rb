class RemoveNumberOfHullsConstraintFromVessels < ActiveRecord::Migration[5.0]
  def change
    change_column :vessels, :number_of_hulls, :string, null: true
  end
end

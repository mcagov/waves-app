class ChangeYearOfBuildDatatype < ActiveRecord::Migration[5.2]
  def change
    remove_column :vessels, :year_of_build, :string
    add_column :vessels, :year_of_build, :integer
  end
end

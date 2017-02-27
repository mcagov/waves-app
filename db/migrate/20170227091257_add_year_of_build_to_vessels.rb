class AddYearOfBuildToVessels < ActiveRecord::Migration[5.0]
  def change
    add_column :vessels, :year_of_build, :string
  end
end

class AddPartToVessels < ActiveRecord::Migration[5.0]
  def change
    add_column :vessels, :part, :string, index: true
  end
end

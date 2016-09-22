class AddRegNoToVessels < ActiveRecord::Migration[5.0]
  def change
    add_column :vessels, :reg_no, :string
    add_index :vessels, :reg_no
  end
end

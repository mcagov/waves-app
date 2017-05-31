class AddEcNoToVessels < ActiveRecord::Migration[5.0]
  def change
    add_column :vessels, :ec_no, :string
  end
end

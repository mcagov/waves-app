class RemoveEcNoFromVessels < ActiveRecord::Migration[5.2]
  def change
    remove_column :vessels, :ec_no, :string
  end
end

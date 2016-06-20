class ChangeOwnersNationality < ActiveRecord::Migration
  def up
    change_column :owners, :nationality, :string, limit: 2
  end

  def down
    change_column :owners, :nationality, :string, limit: nil
  end
end

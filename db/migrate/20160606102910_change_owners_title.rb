class ChangeOwnersTitle < ActiveRecord::Migration
  def change
    change_column_null :owners, :title, true
  end
end

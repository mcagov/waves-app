class DropCharterParties < ActiveRecord::Migration[5.1]
  def up
    drop_table(:charter_parties, if_exists: true)
  end
end

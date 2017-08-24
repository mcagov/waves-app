class AddIndexToNotesEntityType < ActiveRecord::Migration[5.1]
  def change
    add_index :notes, :entity_type
  end
end

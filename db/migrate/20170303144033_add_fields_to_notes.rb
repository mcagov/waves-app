class AddFieldsToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :entity_type, :string, index: true
    add_column :notes, :issuing_authority, :string
    add_column :notes, :expires_at, :datetime
  end
end

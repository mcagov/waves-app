class RemoveFileFromDeclarations < ActiveRecord::Migration[5.0]
  def change
    remove_column :declarations, :completed_form_file_name, :string
    remove_column :declarations, :completed_form_content_type, :string
    remove_column :declarations, :completed_form_file_size, :integer
    remove_column :declarations, :completed_form_updated_at, :datetime
  end
end

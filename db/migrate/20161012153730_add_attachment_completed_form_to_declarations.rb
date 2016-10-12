class AddAttachmentCompletedFormToDeclarations < ActiveRecord::Migration
  def self.up
    change_table :declarations do |t|
      t.attachment :completed_form
    end
  end

  def self.down
    remove_attachment :declarations, :completed_form
  end
end

class RenameSequenceNumbersScope < ActiveRecord::Migration[5.0]
  def change
    rename_column :sequence_numbers, :scope, :context
  end
end

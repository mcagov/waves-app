class CreateSequenceNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :sequence_numbers do |t|
      t.string   :type, index: true
      t.string   :scope, index: true
      t.string   :generated_number, index: true
      t.timestamps
    end
  end
end

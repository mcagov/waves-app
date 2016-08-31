class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.uuid :noteable_id, index: true
      t.string :noteable_type, index: true
      t.uuid :actioned_by_id, index: true
      t.string :type, index: true
      t.string :subject
      t.string :format
      t.datetime :noted_at
      t.text :content
      t.timestamps
    end
  end
end

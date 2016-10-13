class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.attachment :file
      t.uuid :owner_id, index: true
      t.string :owner_type, index: true
    end
  end
end

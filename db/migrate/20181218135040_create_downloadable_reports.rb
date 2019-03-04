class CreateDownloadableReports < ActiveRecord::Migration[5.2]
  def change
    create_table :downloadable_reports, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :user_id
      t.datetime :file_updated_at
      t.integer :file_file_size
      t.string :file_content_type
      t.string :file_file_name
      t.timestamps
    end
  end
end

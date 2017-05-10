class DropUnusedTables < ActiveRecord::Migration[5.0]
  def up
    drop_table_if_exists :documentation_pages
    drop_table_if_exists :documentation_screenshots
    drop_table_if_exists :nifty_attachments
  end

  def down
  end

  private

  def drop_table_if_exists(table_name)
    drop_table table_name if ActiveRecord::Base.connection.table_exists?(table_name)
  end
end

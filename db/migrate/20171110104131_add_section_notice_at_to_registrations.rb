class AddSectionNoticeAtToRegistrations < ActiveRecord::Migration[5.1]
  def change
    add_column :registrations, :section_notice_at, :datetime
  end
end

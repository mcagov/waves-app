class CleanupSubmissionsFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :submissions, :ip_country, :string
    remove_column :submissions, :card_country, :string
    remove_column :submissions, :receipt_id, :string
    remove_column :submissions, :register, :string
    remove_column :submissions, :task, :strong

    add_column :submissions, :part, :string
    add_column :submissions, :type, :string, index: true
  end
end

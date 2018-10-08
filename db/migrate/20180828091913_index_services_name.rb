class IndexServicesName < ActiveRecord::Migration[5.2]
  def change
    add_index :services, :name
  end
end

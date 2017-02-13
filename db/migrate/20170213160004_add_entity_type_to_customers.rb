class AddEntityTypeToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :entity_type, :string, default: :individual, index: true
  end
end

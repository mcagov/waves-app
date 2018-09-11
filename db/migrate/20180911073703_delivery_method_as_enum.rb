class DeliveryMethodAsEnum < ActiveRecord::Migration[5.2]
  def change
    remove_column :carving_and_markings, :delivery_method, :string
    add_column :carving_and_markings, :delivery_method, :integer
  end
end

class RemovePaymentIdFromSubmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :submissions, :payment_id, :uuid
  end
end

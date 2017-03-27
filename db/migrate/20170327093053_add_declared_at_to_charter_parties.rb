class AddDeclaredAtToCharterParties < ActiveRecord::Migration[5.0]
  def change
    add_column :charter_parties, :declaration_signed, :boolean, default: false
  end
end

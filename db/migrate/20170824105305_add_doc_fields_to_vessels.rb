class AddDocFieldsToVessels < ActiveRecord::Migration[5.1]
  def change
    add_column :vessels, :doc_issuing_authority, :string
    add_column :vessels, :doc_auditor, :string
  end
end

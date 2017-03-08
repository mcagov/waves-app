class AddTemplateToCarvingAndMarkings < ActiveRecord::Migration[5.0]
  def change
    add_column :carving_and_markings, :template, :string
  end
end

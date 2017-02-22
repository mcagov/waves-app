class CreateMortgages < ActiveRecord::Migration[5.0]
  def change
    create_table :mortgages, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :parent_id
      t.string :parent_type, index: true
      t.string :mortgage_type
      t.string :reference_number
      t.date :start_date
      t.date :end_date
      t.string :amount
      t.string :mortgagor
      t.timestamps
    end

    create_table :mortgagees, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :mortgage_id
      t.string :name
      t.string :address
      t.string :contact_details
      t.timestamps
    end
  end
end

class CreateCharterers < ActiveRecord::Migration[5.0]
  def change
    create_table :charterers, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid     :parent_id
      t.string   :parent_type
      t.string   :reference_number
      t.date     :start_date
      t.date     :end_date
      t.timestamps
    end
  end
end

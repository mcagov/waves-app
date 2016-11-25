class CreatePrintJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :print_jobs, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid     :printable_id, index: true
      t.string   :printable_type, index: true
      t.string   :template, index: true
      t.uuid     :printed_by
      t.datetime :printed_at
    end
  end
end

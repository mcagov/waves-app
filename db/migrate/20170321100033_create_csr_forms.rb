class CreateCsrForms < ActiveRecord::Migration[5.0]
  def change
    create_table :csr_forms, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid        :submission_id
      t.uuid        :vessel_id
      t.integer     :issue_number
      t.datetime    :issued_at
      t.string      :flag_state, default: "United Kingdom"
      t.datetime    :registered_at
      t.string      :vessel_name
      t.string      :port_name
      t.string      :owner_names
      t.string      :owner_addresses
      t.string      :owner_identification_number
      t.string      :charterer_names
      t.string      :charterer_addresses
      t.string      :manager_name
      t.string      :manager_address
      t.string      :safety_management_address
      t.string      :manager_company_number
      t.string      :classification_societies
      t.string      :document_of_compliance_issuer
      t.string      :document_of_compliance_auditor
      t.string      :smc_issuer
      t.string      :smc_auditor
      t.string      :issc_issuer
      t.string      :issc_auditor
      t.string      :remarks
      t.timestamps
    end
  end
end

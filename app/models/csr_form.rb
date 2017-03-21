class CsrForm < ApplicationRecord
  class << self
    def for(submission)
      vessel = submission.registered_vessel
      CsrForm.new(
        submission_id: submission.id,
        vessel_id: submission.registered_vessel.id,
        issue_number: csr_issue_number,
        issued_at: Date.today,
        registered_at: first_registration_date,
        vessel_name: vessel.name,
        port_name: WavesUtilities::Port.new(vessel.port_code).name,
        owner_names: vessel.owners.map(&:name).join("; "),
        owner_addresses: vessel.owners.map(&:inline_address).join("; "),
        owner_identification_number: vessel.owners.map(&:imo_number).join("; "),
        charterer_names: vessel.charter_parties.map(&:name).join("; "),
        charterer_addresses: vessel.charter_parties.map(&:address).join("; "),
        manager_name: vessel.managers.map(&:name).join("; "),
        manager_address: vessel.managers.map(&:inline_address).join("; "),
        safety_management_address: (vessel.managers.first.safety_management.inline_address if vessel.managers.first && vessel.managers.first.safety_management),
        manager_company_number: vessel.managers.map(&:imo_number).join("; "),
        classification_societies: [vessel.classification_society, vessel.classification_society_other].compact.join("; "),
        document_of_compliance_issuer: nil,
        document_of_compliance_auditor: nil,
        smc_issuer: vessel.smc_issuing_authority,
        smc_auditor: vessel.smc_auditor,
        issc_issuer: vessel.issc_issuing_authority,
        issc_auditor: vessel.issc_auditor
      )
    end

    def csr_issue_number
      1
    end

    def first_registration_date
      100.years.ago
    end
  end
end

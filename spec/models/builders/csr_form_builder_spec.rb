require "rails_helper"

describe Builders::CsrFormBuilder do
  context "#build" do
    let!(:vessel) do
      create(
        :registered_vessel,
        part: 1,
        name: "PIRATE SHIP",
        port_code: "SU",
        owners: [owner_1, owner_2],
        managers: [manager],
        charterers: [charterer],
        classification_society: "XX",
        classification_society_other: "YY",
        smc_issuing_authority: "SMC_I",
        smc_auditor: "SMC_A",
        issc_issuing_authority: "ISSC_I",
        issc_auditor: "ISSC_A",
        registrations: [first_registration])
    end

    let!(:submission) do
      create(
        :assigned_submission,
        task: :issue_csr,
        part: :part_1,
        registered_vessel: vessel)
    end

    let(:owner_1) do
      build(
        :registered_owner,
        name: "ALICE", address_1: "AA ST", imo_number: "AA1")
    end

    let(:owner_2) do
      build(
        :registered_owner,
        name: "BOB", address_1: "BB ST", imo_number: "BB2")
    end

    let(:manager) do
      build(
        :manager,
        name: "MIKE", address_1: "MIKES HOUSE", imo_number: "12345",
        safety_management: build(:safety_management, address_1: "SM STREET"))
    end

    let(:charterer) do
      build(
        :charterer,
        charter_parties:
          [build(:charter_party, name: "CHARLIE", address: "MAIN STREET")])
    end

    let(:first_registration) do
      build(
        :registration,
        registered_at: "1/1/2010")
    end

    subject { described_class.build(submission) }

    context "with an existing CsrForm" do
      let!(:submission_csr_form) { create(:csr_form, submission: submission) }

      it "retrieves the existing CsrForm" do
        expect(subject).to eq(submission_csr_form)
      end
    end

    it "assigns the expected attributes" do
      csr_form = subject
      expect(csr_form).to be_persisted
      expect(csr_form.vessel_id).to eq(vessel.id)
      expect(csr_form.issue_number).to be_blank
      expect(csr_form.issued_at).to be_present
      expect(csr_form.registered_at).to eq(Date.new(2010, 1, 1))

      expect(csr_form.vessel_name).to eq("PIRATE SHIP")
      expect(csr_form.port_name).to eq("SOUTHAMPTON")

      expect(csr_form.owner_names).to eq("ALICE; BOB")
      expect(csr_form.owner_addresses).to eq("AA ST; BB ST")
      expect(csr_form.owner_identification_number).to eq("AA1; BB2")

      expect(csr_form.charterer_names).to eq("CHARLIE")
      expect(csr_form.charterer_addresses).to eq("MAIN STREET")

      expect(csr_form.manager_name).to eq("MIKE")
      expect(csr_form.manager_address).to eq("MIKES HOUSE")
      expect(csr_form.safety_management_address).to eq("SM STREET")
      expect(csr_form.manager_company_number).to eq("12345")

      expect(csr_form.classification_societies).to eq("XX; YY")
      expect(csr_form.smc_issuer).to eq("SMC_I")
      expect(csr_form.smc_auditor).to eq("SMC_A")
      expect(csr_form.issc_issuer).to eq("ISSC_I")
      expect(csr_form.issc_auditor).to eq("ISSC_A")
    end
  end
end

def separator
  "; "
end

def vessel_registered_at
  "1/1/2011"
end

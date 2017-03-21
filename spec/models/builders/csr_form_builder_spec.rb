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
        issc_auditor: "ISSC_A")
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

    subject { described_class.build(submission) }

    context "with an existing CsrForm" do
      let!(:submission_csr_form) { create(:csr_form, submission: submission) }

      it "retrieves the existing CsrForm" do
        expect(subject).to eq(submission_csr_form)
      end
    end

    context "expected attributes" do
      it { expect(subject.vessel_id).to eq(vessel.id) }
      it { expect(subject.issue_number).to eq(1) }
      it { expect(subject.issued_at).to be_present }

      it { expect(subject.vessel_name).to eq("PIRATE SHIP") }
      it { expect(subject.port_name).to eq("SOUTHAMPTON") }

      it { expect(subject.owner_names).to eq("ALICE; BOB") }
      it { expect(subject.owner_addresses).to eq("AA ST; BB ST") }
      it { expect(subject.owner_identification_number).to eq("AA1; BB2") }

      it { expect(subject.charterer_names).to eq("CHARLIE") }
      it { expect(subject.charterer_addresses).to eq("MAIN STREET") }

      it { expect(subject.manager_name).to eq("MIKE") }
      it { expect(subject.manager_address).to eq("MIKES HOUSE") }
      it { expect(subject.safety_management_address).to eq("SM STREET") }
      it { expect(subject.manager_company_number).to eq("12345") }

      it { expect(subject.classification_societies).to eq("XX; YY") }
      it { expect(subject.smc_issuer).to eq("SMC_I") }
      it { expect(subject.smc_auditor).to eq("SMC_A") }
      it { expect(subject.issc_issuer).to eq("ISSC_I") }
      it { expect(subject.issc_auditor).to eq("ISSC_A") }
    end
  end
end

def separator
  "; "
end

def vessel_registered_at
  "1/1/2011"
end

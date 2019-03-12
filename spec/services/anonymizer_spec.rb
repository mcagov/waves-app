require "rails_helper"

describe Anonymizer do
  context "in general" do
    let!(:vessel) { create(:registered_vessel) }
    let!(:submission) { create(:submission, registered_vessel: vessel) }
    let!(:payment) { create(:payment, submission: submission) }
    let!(:finance_payment) { create(:finance_payment, payment: payment) }

    let(:anon) { Anonymizer::ANON }

    before do
      Anonymizer.new(vessel).perform
      vessel.reload
      submission.reload
      finance_payment.reload
    end

    it "scrubs the customers table" do
      vessel.customers.each do |customer|
        expect(customer.email).to eq(anon)
        expect(customer.phone_number).to eq(anon)
      end

      submission.beneficial_owners.each do |beneficial_owner|
        expect(beneficial_owner.email).to eq(anon)
        expect(beneficial_owner.phone_number).to eq(anon)
      end

      submission.directed_bys.each do |directed_by|
        expect(directed_by.email).to eq(anon)
        expect(directed_by.phone_number).to eq(anon)
      end

      submission.managed_bys.each do |managed_by|
        expect(managed_by.email).to eq(anon)
        expect(managed_by.phone_number).to eq(anon)
      end

      submission.managers.each do |manager|
        expect(manager.email).to eq(anon)
        expect(manager.phone_number).to eq(anon)
      end

      submission.charter_parties.each do |charter_party|
        expect(charter_party.email).to eq(anon)
        expect(charter_party.phone_number).to eq(anon)
      end
    end

    it "scrubs the finance_payments table" do
      expect(finance_payment.applicant_email).to eq(anon)
      expect(finance_payment.applicant_name).to eq(anon)
      expect(finance_payment.payer_name).to eq(anon)
      expect(finance_payment.payment_reference).to eq(anon)
    end

    it "scrubs the submissions table" do
      expect(submission.applicant_email).to eq(anon)

      submission.owners.each do |owner|
        expect(owner.email).to eq(anon)
        expect(owner.phone_number).to eq(anon)
      end

      expect(submission.agent.email).to eq(anon)
      expect(submission.agent.phone_number).to eq(anon)

      expect(submission.representative.email).to eq(anon)
      expect(submission.representative.phone_number).to eq(anon)
    end

    it "scrubs the registrations #registry_info" do
      vessel.registrations.each do |registration|
        registration.owners.each do |owner|
          expect(owner.email).to eq(anon)
          expect(owner.phone_number).to eq(anon)
        end

        expect(registration.registry_info[:agent][:email]).to eq(anon)
        expect(registration.registry_info[:agent][:phone_number]).to eq(anon)

        registration.registry_info[:charterers].each do |charterer|
          charterer[:charter_parties].each do |charter_party|
            expect(charter_party[:email]).to eq(anon)
            expect(charter_party[:phone_number]).to eq(anon)
          end
        end

        registration.registry_info[:beneficial_owners].each do |benef_owner|
          expect(benef_owner[:email]).to eq(anon)
          expect(benef_owner[:phone_number]).to eq(anon)
        end

        registration.registry_info[:directed_bys].each do |directed_by|
          expect(directed_by[:email]).to eq(anon)
          expect(directed_by[:phone_number]).to eq(anon)
        end

        registration.registry_info[:managed_bys].each do |managed_by|
          expect(managed_by[:email]).to eq(anon)
          expect(managed_by[:phone_number]).to eq(anon)
        end

        registration.registry_info[:managers].each do |manager|
          expect(manager[:email]).to eq(anon)
          expect(manager[:phone_number]).to eq(anon)
        end

        representative = registration.registry_info[:representative]
        expect(representative[:email]).to eq(anon)
        expect(representative[:phone_number]).to eq(anon)
      end
    end

    it "sets the vessel's #scrubbed_at"
  end
end

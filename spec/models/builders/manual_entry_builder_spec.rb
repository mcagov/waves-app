require "rails_helper"

describe Builders::ManualEntryBuilder do
  context ".convert_to_application" do
    let!(:registered_vessel) { create(:register_vessel) }

    let!(:submission) do
      Builders::ManualEntryBuilder
        .convert_to_application(finance_payment.submission)
    end

    context "in general" do
      let!(:finance_payment) do
        create(
          :finance_payment,
          vessel_name: "MV BOB",
          vessel_reg_no: registered_vessel.reg_no,
          applicant_name: "BOB",
          applicant_email: "bob@example.com",
          documents_received: "rock scissors paper")
      end

      it "no longer requires officer_intervention" do
        expect(submission.officer_intervention_required?).to be_falsey
      end

      it "is associates the submission with the registered_vessel" do
        expect(submission.registered_vessel).to eq(registered_vessel)
      end

      it "buils the correspondent" do
        expect(submission.correspondent.name).to eq("BOB")
        expect(submission.correspondent.email).to eq("bob@example.com")
      end
    end

    context "with minimal attributes" do
      let!(:finance_payment) { create(:finance_payment) }

      it "no longer requires officer_intervention" do
        expect(submission.officer_intervention_required?).to be_falsey
      end

      it "sets the expected attributes" do
        expect(submission.vessel.name).to be_blank
        expect(submission.correspondent).to be_nil
      end
    end
  end
end

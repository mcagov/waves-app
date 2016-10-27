require "rails_helper"

describe Builders::ManualEntryBuilder do
  context ".convert_to_application" do
    let!(:registered_vessel) { create(:registered_vessel) }

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

      it "is associates the submission with the registered_vessel" do
        expect(submission.registered_vessel).to eq(registered_vessel)
      end

      it "builds the correspondent" do
        expect(submission.correspondent.name).to eq("BOB")
        expect(submission.correspondent.email).to eq("bob@example.com")
      end
    end

    context "with minimal attributes" do
      let!(:finance_payment) { create(:finance_payment) }

      it "does not build the vessel or correspondent" do
        expect(submission.vessel.name).to be_blank
        expect(submission.correspondent).to be_nil
      end
    end
  end
end

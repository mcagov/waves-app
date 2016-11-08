require "rails_helper"

describe Payment::FinancePayment do
  context "with valid params" do
    let!(:finance_payment) do
      described_class.create(
        payment_date: Date.today,
        part: :part_1,
        task: :unknown,
        payment_type: :cash,
        payment_amount: "25",
        actioned_by: create(:user)
      )
    end

    it "is actioned_by a user" do
      expect(finance_payment.actioned_by).to be_present
    end

    it "creates the payment with the expected amount" do
      expect(finance_payment.payment.amount).to eq(2500)
    end

    it "has a submission ref_no" do
      expect(finance_payment.submission_ref_no).to be_present
    end

    it "sets the officer_intervention_required flag" do
      expect(finance_payment.submission.officer_intervention_required)
        .to be_truthy
    end

    it "sets the source" do
      expect(finance_payment.submission.source.to_sym).to eq(:manual_entry)
    end

    it "sets the state to unassigned so it is ready to be claimed" do
      expect(finance_payment.submission).to be_unassigned
    end

    it "sets the target date" do
      expect(finance_payment.submission.target_date).to be_present
    end
  end

  context "for a change_registry_details submission" do
    let!(:finance_payment) do
      described_class.create(
        payment_date: Date.today,
        part: :part_1,
        task: :change_registry_details,
        vessel_reg_no: create(:registered_vessel).reg_no,
        payment_type: :cash,
        payment_amount: "15",
        actioned_by: create(:user)
      )
    end

    it "sets the state to unassigned so it is ready to be claimed" do
      expect(finance_payment.submission).to be_unassigned
    end

    it "sets the target date" do
      expect(finance_payment.submission.target_date).to be_present
    end
  end

  context "with invalid params" do
    let!(:finance_payment) do
      described_class.create(
        part: nil,
        payment_amount: "bob",
        task: nil
      )
    end

    it { expect(finance_payment.errors).to include(:payment_date) }
    it { expect(finance_payment.errors).to include(:part) }
    it { expect(finance_payment.errors).to include(:payment_amount) }
    it { expect(finance_payment.errors).to include(:task) }

    it "does not create the payment" do
      expect(finance_payment.payment).to be_nil
    end
  end
end

require "rails_helper"

describe Payment::FinancePayment do
  context "for a new application" do
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

    it "does not have a submission ref_no" do
      expect(finance_payment.submission_ref_no).to be_blank
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

  context "for an existing application (when submission_ref_no is valid)" do
    let(:submission) { create(:assigned_submission) }

    let!(:finance_payment) do
      described_class.create(
        payment_date: Date.today,
        payment_amount: "25",
        actioned_by: create(:user),
        submission_ref_no: submission.ref_no
      )
    end

    it "does not change the state of the existing submission" do
      expect(submission.reload.current_state).to eq(:assigned)
    end

    it "does not set the officer_intervention_required flag" do
      expect(submission.reload.officer_intervention_required).to be_falsey
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

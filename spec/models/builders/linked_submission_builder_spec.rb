require "rails_helper"

xdescribe Builders::LinkedSubmissionBuilder do
  let!(:payment) { create(:payment) }
  let!(:source_submission) { payment.submission }
  let!(:target_submission) { create(:submission, ref_no: "ABC123") }

  let(:target_ref

  let!(:result) do
    described_class.create(source_submission, target_ref_no)
  end

  context "with a valid target_ref_no" do
    it "returns the target_submission" do
      expect(result).to eq(target_submission)
    end

    it "destroys the source_submission" do
      expect(source_submission).to be_destroyed
    end

    it "assigns the payment to the target_submission" do
      expect(result.payments.first).to eq(payment)
    end
  end

  context "with an invalid target_ref_no" do
    let(:target_ref_no) { "foo" }

    it "returns nil" do
      expect(result).to be_nil
    end

    it "retains the source_submission" do
      expect(source_submission.reload).to be_present
    end

    it "retains the source_submission#payment" do
      expect(payment.reload.submission).to eq(source_submission)
    end
  end
end

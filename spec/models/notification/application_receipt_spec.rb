require "rails_helper"

describe Notification::ApplicationReceipt, type: :model do
  context "in general" do
    let(:submission) { create_incomplete_paid_submission! }
    subject { described_class.new(notifiable: submission) }

    it "has the expected email_template" do
      expect(subject.email_template).to eq(:application_receipt)
    end

    it "has additional_params" do
      expect(subject.additional_params)
        .to eq(
          world_pay_transaction_no: submission.payment.wp_order_code,
          submission_ref_no: submission.ref_no
        )
    end
  end
end

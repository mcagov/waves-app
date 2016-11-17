require "rails_helper"

describe Builders::WorldPayPaymentBuilder do
  context ".create" do
    let(:payment_params) do
      {
        submission_id: create(:submission).id,
        wp_amount: "25.00",
        customer_ip: "127.0.0.1",
      }
    end

    subject do
      Builders::WorldPayPaymentBuilder.create(payment_params)
    end

    it "has the expected amount" do
      expect(subject.amount).to eq(25.00)
    end

    it "has the expected remittance attributes" do
      expect(subject.remittance.customer_ip).to eq("127.0.0.1")
    end
  end
end

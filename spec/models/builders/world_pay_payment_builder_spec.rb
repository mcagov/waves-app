require "rails_helper"

describe Builders::WorldPayPaymentBuilder do
  context ".create" do
    let(:payment_params) do
      {
        submission_id: create(:new_registration).id,
        wp_token: "TOKEN",
        wp_order_code: "ORDER1",
        wp_amount: "25.00",
        wp_country: "BULGARIA",
        customer_ip: "127.0.0.1",
        wp_payment_response: { foo: "bar" },
      }
    end

    subject do
      Builders::WorldPayPaymentBuilder.create(payment_params)
    end

    it "has the expected amount" do
      expect(subject.amount).to eq(25.00)
    end

    it "has the expected remittance attributes" do
      expect(subject.remittance.wp_token).to eq("TOKEN")
      expect(subject.remittance.wp_order_code).to eq("ORDER1")
      expect(subject.remittance.wp_country).to eq("BULGARIA")
      expect(subject.remittance.customer_ip).to eq("127.0.0.1")
      expect(subject.remittance.wp_payment_response["foo"]).to eq("bar")
    end
  end
end

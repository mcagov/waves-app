require "rails_helper"

describe "create payments via the API", type: :request do
  before do
    post api_v1_payments_path, params: params
  end

  context "with valid params" do
    let!(:submission) { create(:submission) }
    let(:params) { valid_create_payment_json(submission) }
    let(:payment) { Payment.find(json["id"]) }
    let(:parsed_body) { JSON.parse(response.body) }

    before do
      allow(Builders::WorldPayPaymentBuilder)
        .to receive(:create)
        .with({})
        .and_return(payment)
    end

    it "returns the status code :created" do
      expect(response).to have_http_status(:created)
    end

    it "responds with the payment id" do
      expect(parsed_body["data"]["id"]).to be_present
    end

    it "builds the application_receipt notification" do
      expect(payment.submission.application_receipt).to be_present
    end

    it "sets the application_name" do
      expect(payment.submission.application_receipt).to be_present
    end

    it "builds the application_receipt notification" do
      expect(payment.submission.application_receipt).to be_present
    end
  end

  context "with invalid params" do
    let(:params) { invalid_create_payment_json }

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

# rubocop:disable all
def valid_create_payment_json(submission)
  {"data"=>{"type"=>"payments", "attributes"=>{"submission_id"=>"#{submission.id}", "wp_amount"=>2500, "wp_order_code"=>"ORDER_CODE", "customer_ip"=>"127.0.0.1"}}}
end

def invalid_create_payment_json
  {"data"=>{"type"=>"foobars", "attributes"=>{"submission_id"=>"bob"}}, "payment"=>{ }}
end
# rubocop:enable all

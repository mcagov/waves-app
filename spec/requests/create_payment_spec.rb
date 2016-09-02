require "rails_helper"

describe "create payments via the API", type: :request do
  before do
    create(:submission, id: "240cdfa3-c930-4829-99a0-6c160a631d2d")
    post api_v1_payments_path, params: params
  end

  context "with valid params" do
    let(:params) { valid_create_payment_json }
    let(:payment) { Payment.find(json["id"]) }
    let(:parsed_body) { JSON.parse(response.body) }

    it "returns the status code :created" do
      expect(response).to have_http_status(:created)
    end

    it "responds with the payment id" do
      expect(parsed_body["data"]["id"]).to be_present
    end

    it "sets the payment#amount" do
      expect(payment.wp_amount).to eq("2500")
    end

    it "sets the payment#wp_order_code" do
      expect(payment.wp_order_code).to eq(
        "8481b725-e7c8-4c94-b311-9fa2f10748ae")
    end

    it "sets the payment#wp_country" do
      expect(payment.wp_country).to eq("GB")
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
def valid_create_payment_json
  {"data"=>{"type"=>"payments", "attributes"=>{"submission_id"=>"240cdfa3-c930-4829-99a0-6c160a631d2d", "wp_token"=>"TEST_SU_84dbf02a-f537-4047-ab3c-1806dad6aa03", "wp_order_code"=>"8481b725-e7c8-4c94-b311-9fa2f10748ae", "wp_amount"=>2500, "wp_country"=>"GB", "wp_payment_response"=>{ }, "customer_ip"=>"127.0.0.1"}}}
end

def invalid_create_payment_json
  {"data"=>{"type"=>"foobars", "attributes"=>{"submission_id"=>""}}, "payment"=>{ }}
end
# rubocop:enable all

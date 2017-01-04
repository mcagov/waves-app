require "rails_helper"

describe "Client session" do
  let(:parsed_attrs) { JSON.parse(response.body)["data"]["attributes"] }

  context "#create" do
    before do
      allow_any_instance_of(ClientSession)
        .to receive(:obfuscated_recipient_phone_number).and_return([1, 2])

      allow_any_instance_of(ClientSession)
        .to receive(:save).and_return(successfully_created)

      post api_v1_client_sessions_path, params: create_params
    end

    let(:successfully_created) { true }

    context "when the client_session is created" do
      it "has the status :created" do
        expect(response).to have_http_status(:created)
      end

      it "has the delivered_to" do
        expect(parsed_attrs["delivered_to"]).to eq([1, 2])
      end

      it "has the customer_id" do
        expect(parsed_attrs.keys).to include("customer_id")
      end
    end

    context "when the client_session is not created" do
      let(:successfully_created) { false }

      it "has status 404" do
        expect(response).to have_http_status(404)
      end

      it "does not create a submission" do
        expect(ClientSession.count).to eq(0)
      end
    end
  end

  context "#create raises an API error" do
    before do
      allow_any_instance_of(ClientSession)
        .to receive(:save).and_raise(WavesError::SmsProviderError)

      post api_v1_client_sessions_path, params: create_params
    end

    it "has status 404" do
      expect(response).to have_http_status(404)
    end
  end
end

# rubocop:disable all
def create_params
  {"data"=>{"attributes"=>{"vessel_reg_no"=>"foo","external_session_key"=>"bar"}}}
end
# rubocop:enable all

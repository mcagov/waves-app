require "rails_helper"

describe "Client session" do
  let(:parsed_attrs) { JSON.parse(response.body)["data"]["attributes"] }

  context "#create" do
    before do
      allow_any_instance_of(ClientSession)
        .to receive(:save).and_return(successfully_created)

      # this stub is introduced to fix breaking spec after
      # upgrade to Rails 2.5.1. Not clear *why* the serialize
      # is rendered now, versus wasn't rendered before
      allow_any_instance_of(ClientSessionSerializer)
        .to receive(:delivered_to).and_return(:foo)

      post api_v1_client_sessions_path, params: create_params
    end

    context "when the client_session is created" do
      let(:successfully_created) { true }

      it "has the status :created" do
        expect(response).to have_http_status(:created)
      end
    end

    context "when the client_session is not created" do
      let(:successfully_created) { false }

      it "has status 404" do
        expect(response).to have_http_status(404)
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

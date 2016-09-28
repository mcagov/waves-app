require "rails_helper"

describe "Validate an owner" do
  context "client_session#create" do
    let(:parsed_attrs) { JSON.parse(response.body)["data"]["attributes"] }

    before do
      allow(ClientSession).to receive(:create).and_return(bln)
      post api_v1_client_sessions_path, params: create_params
    end

    context "when the client_session is created" do
      let(:bln) { true }

      it "has the status :created" do
        expect(response).to have_http_status(:created)
      end

      it "returns the client_session_id"
    end

    context "when the client_session is not created" do
      let(:bln) { false }

      it "has status 404" do
        expect(response).to have_http_status(404)
      end

      it "does not create a submission" do
        expect(ClientSession.count).to eq(0)
      end
    end
  end

  context "client_session#update" do
    context "with valid params" do
      it "returns the Submission::RenewRegistration"
    end
  end
end

# rubocop:disable all
def create_params
  {"data"=>{"attributes"=>{"vessel_reg_no"=>"foo","client_session_id"=>"bar"}}}
end
# rubocop:enable all

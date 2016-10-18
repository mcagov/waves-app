require "rails_helper"

describe "create new new_registrations via the API", type: :request do
  before { post api_v1_new_registrations_path, params: params }

  context "with valid params" do
    let(:params) { valid_create_new_registration_json }
    let(:submission) { Submission.find(json["id"]) }
    let(:parsed_body) { JSON.parse(response.body) }

    it "returns the status code :created" do
      expect(response).to have_http_status(:created)
    end

    it "responds with the submission id" do
      expect(parsed_body["data"]["id"]).to be_present
    end

    it "responds with the ref_no" do
      expect(parsed_body["data"]["attributes"]["ref-no"]
            ).to eq(submission.ref_no)
    end

    it "creates a part_3 new_registration" do
      expect(submission.part.to_sym).to eq(:part_3)
    end
  end

  context "with invalid params" do
    let(:params) { invalid_create_new_registration_json }

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

# rubocop:disable all
def valid_create_new_registration_json(changeset = "")
  {"data"=>{"type"=>"new_registrations", "attributes"=>{"part" => "part_3", "changeset"=>changeset}}, "new_registration"=>{ }}
end

def invalid_create_new_registration_json
  {"data"=>{"type"=>"foobars", "attributes"=>{"part"=>""}}, "new_registration"=>{ }}
end
# rubocop:enable all

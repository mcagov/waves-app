require "rails_helper"

describe "create registrations via the API", type: :request do

  context "with valid params" do
    before do
      post api_v1_registrations_path, params: valid_create_registration_json
    end

    it "creates the record" do
      expect(json["id"]).to be_present
    end

    it "returns the status code :created" do
      expect(response).to have_http_status(:created)
    end
  end

  context "with invalid params" do
    before do
      post api_v1_registrations_path, params: invalid_create_registration_json
    end

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

def valid_create_registration_json
  {"data"=>{"type"=>"registrations", "attributes"=>{"status"=>"foo", "changeset"=>"{}", "task"=>"new_registration"}}, "registration"=>{}}
end

def invalid_create_registration_json
  {"data"=>{"type"=>"registrations", "attributes"=>{"status"=>"", "changeset"=>"{}", "task"=>"new_registration"}}, "registration"=>{}}
end

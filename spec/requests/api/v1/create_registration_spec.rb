require "rails_helper"

describe "create registrations via the API", type: :request do
  before { post api_v1_registrations_path, params: params }

  context "with valid params" do
    let(:params) { valid_create_registration_json }

    it "creates the record" do
      expect(json["id"]).to be_present
    end

    it "returns the status code :created" do
      expect(response).to have_http_status(:created)
    end
  end

  context "with invalid params" do
    let(:params) { invalid_create_registration_json }

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "with vessel_info in the changeset" do
    let(:params) { valid_create_registration_json(vessel_info_changeset) }

    it "creates a registration for the vessel Foo" do
      registration = Registration.find(json["id"])
      expect(registration.vessel_info[:name]).to eq("Foo")
    end
  end
end

def valid_create_registration_json(changeset="")
  {"data"=>{"type"=>"registrations", "attributes"=>{"status"=>"foo", "changeset"=>changeset, "task"=>"new_registration"}}, "registration"=>{}}
end

def invalid_create_registration_json
  {"data"=>{"type"=>"registrations", "attributes"=>{"status"=>"", "changeset"=>"{}", "task"=>"new_registration"}}, "registration"=>{}}
end

def vessel_info_changeset
  {"vessel_info"=>{"name"=>"Foo"}}.to_json
end

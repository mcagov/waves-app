require "rails_helper"

describe "create registrations via the API", type: :request do
  before { post api_v1_registrations_path, params: params }

  context "with valid params" do
    let(:params) { valid_create_registration_json }
    let(:registration) { Registration.find(json["id"])}

    it "creates a part_3 registration" do
      expect(registration.register.to_sym).to eq(:part_3)
    end

    it "sets the registration#task" do
      expect(registration.task.to_sym).to eq(:new_registration)
    end
  end

  context "with invalid params" do
    let(:params) { invalid_create_registration_json }

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

def valid_create_registration_json(changeset="")
  {"data"=>{"type"=>"registrations", "attributes"=>{"register": "part_3","task": "apply_to_register_a_vessel", "changeset"=>changeset, "task"=>"new_registration"}}, "registration"=>{}}
end

def invalid_create_registration_json
  {"data"=>{"type"=>"foobars", "attributes"=>{"task"=>""}}, "registration"=>{}}
end

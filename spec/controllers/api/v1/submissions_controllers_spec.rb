require "rails_helper"

describe Api::V1::SubmissionsController, type: :controller do

  context "#create" do
    before do
      headers = {  "ACCEPT" => "application/json" }
      params = JSON.parse(File.read('spec/fixtures/new_submission.json'))
      post :create, {params: params}, headers
    end

    it "sets the content type" do
      expect(response.content_type).to eq("application/json")
    end

    it "assigns the changeset" do
      expect(assigns(:submission).changeset).to be_present
    end

    it "assigns the vessel name" do
      vessel_info = assigns(:submission).changeset["vessel-info"]
      expect(vessel_info["name"]).to be_present
    end
  end
end

require "rails_helper"

describe Api::V1::PaymentsController, type: :controller do
  context "#create" do
    before do
      create_incomplete_submission!
      headers = { "ACCEPT" => "application/json" }
      params = JSON.parse(File.read("spec/fixtures/new_payment.json"))
      post :create, { params: params }, headers
    end

    it "sets the content type" do
      expect(response.content_type).to eq("application/json")
    end

    it "assigns the submission_id" do
      expect(assigns(:payment).submission_id).to be_present
    end
  end
end

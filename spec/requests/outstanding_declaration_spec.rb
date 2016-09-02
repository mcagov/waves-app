require "rails_helper"

describe "Oustanding Declaration API" do
  let!(:submission) { create_paid_outstanding_declaration_submission! }
  let(:outstanding_declaration) { submission.declarations.incomplete.first }
  let(:parsed_body) { JSON.parse(response.body) }

  before { get api_v1_declaration_path(declaration_id) }

  context "with a valid oustanding declaration" do
    let(:declaration_id) { outstanding_declaration.id }

    it "responds with the status code :ok" do
      expect(response).to have_http_status(200)
    end

    it "responds with the submission" do
      expect(parsed_body["data"]["id"]).to eq(submission.id)
    end
  end

  context "with an already completed declaration" do
    let(:declaration_id) { submission.declarations.completed.first.id }

    it "responds with the status code 404 Not Found" do
      expect(response).to have_http_status(404)
    end
  end

  context "with an invalid declaration id" do
    let(:declaration_id) { "foo" }

    it "responds with the status code 404 Not Found" do
      expect(response).to have_http_status(404)
    end
  end
end

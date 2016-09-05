require "rails_helper"

describe "Oustanding Declaration API" do
  let(:parsed_body) { JSON.parse(response.body) }
  before { get api_v1_declaration_path(declaration_id) }

  context "with a valid oustanding declaration" do
    let(:declaration) { create(:declaration) }
    let(:declaration_id) { declaration.id }

    it "responds with the status code :ok" do
      expect(response).to have_http_status(200)
    end

    it "responds with the owner" do
      expect(parsed_body["data"]["attributes"]["owner"]["name"])
        .to eq(declaration.owner.name)
    end
  end

  context "with an already completed declaration" do
    let(:declaration) {  create(:declaration, state: :completed) }
    let(:declaration_id) { declaration.id }

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

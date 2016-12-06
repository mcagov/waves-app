require "rails_helper"

describe "Oustanding Declaration API" do
  before { get api_v1_declaration_path(declaration_id) }

  context "with a valid oustanding declaration" do
    let(:submission) { create_submission_from_api! }
    let(:declaration_id) do
      submission.declarations.incomplete.first.id
    end

    let(:parsed_attrs) { JSON.parse(response.body)["data"]["attributes"] }

    it "responds with the status code :ok" do
      expect(response).to have_http_status(200)
    end

    it "responds with the vessel" do
      expect(parsed_attrs["vessel"]["name"])
        .to eq("CELEBRATOR DOPPELBOCK")
    end

    context "the owner" do
      it "name is EDWARD MCCALLISTER" do
        expect(parsed_attrs["owner"]["name"])
          .to eq("EDWARD MCCALLISTER")
      end

      it "has a nil declared_at date" do
        expect(parsed_attrs["owner"]["declared_at"])
          .to be_nil
      end
    end

    context "the other owners" do
      it "returns one owner" do
        expect(parsed_attrs["other_owners"].length).to eq(1)
      end

      it "name is HORATIO NELSON" do
        expect(parsed_attrs["other_owners"][0]["name"])
          .to eq("HORATIO NELSON")
      end

      it "has a declared_at date" do
        expect(parsed_attrs["other_owners"][0]["declared_at"])
          .to be_present
      end
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

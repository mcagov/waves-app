require "rails_helper"

describe "Complete Declaration API" do
  let!(:submission) { create(:submission) }
  let(:outstanding_declaration) { submission.declarations.incomplete.first }

  context "with a valid declaration" do
    before do
      put api_v1_declaration_path(outstanding_declaration.id)
    end

    it "returns the status code :ok" do
      expect(response).to have_http_status(:ok)
    end

    it "completes the declaration" do
      expect(Declaration.find(outstanding_declaration.id)).to be_completed
    end
  end

  context "with an already completed declaration" do
    before do
      outstanding_declaration.declared!
      put api_v1_declaration_path(outstanding_declaration.id)
    end

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

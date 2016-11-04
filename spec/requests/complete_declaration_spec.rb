require "rails_helper"

describe "Complete Declaration API" do
  let!(:submission) { create(:incomplete_submission) }
  let(:outstanding_declaration) { submission.declarations.incomplete.first }
  let(:params) { completed_declaration_params }

  context "with a valid declaration" do
    before do
      put api_v1_declaration_path(outstanding_declaration.id), params: params
    end

    it "returns the status code :ok" do
      expect(response).to have_http_status(:ok)
    end

    it "updates the owner name" do
      expect(Declaration.find(outstanding_declaration.id).owner.name)
        .to eq("Bob")
    end

    it "completes the declaration" do
      expect(Declaration.find(outstanding_declaration.id)).to be_completed
    end
  end

  context "with an already completed declaration" do
    before do
      outstanding_declaration.declared!
      put api_v1_declaration_path(outstanding_declaration.id), params: params
    end

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

# rubocop:disable all
def completed_declaration_params
  {"data"=>{"type"=>"payments", "attributes"=>{"changeset"=>{"name"=>"Bob"}}}}
end
# rubocop:enable all

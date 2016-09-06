require "rails_helper"

describe "Complete Declaration API" do
  let!(:submission) { create_incomplete_paid_submission! }
  let(:outstanding_declaration) { submission.declarations.incomplete.first }
  let(:params) { completed_declaration_params }

  before do
    put api_v1_declaration_path(declaration_id), params: params
  end

  context "with a valid declaration" do
    let(:declaration_id) { outstanding_declaration.id }

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

    it "sets the submission to unassigned" do
      expect(Submission.find(submission.id)).to be_unassigned
    end
  end

  context "with an already completed declaration" do
    let(:declaration_id) { submission.declarations.completed.first.id }

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "with an invalid declaration id" do
    let(:declaration_id) { "foo" }

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

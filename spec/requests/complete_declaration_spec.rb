require "rails_helper"

describe "Complete Declaration API" do
  let!(:submission) { create_paid_outstanding_declaration_submission! }
  let(:outstanding_declaration) { submission.declarations.incomplete.first }
  let(:params) { { id: declaration_id } }

  before { post api_v1_completed_declarations_path, params: params }

  xcontext "with a valid declaration" do
    let(:declaration_id) { outstanding_declaration.id }

    it "returns the status code :created" do
      expect(response).to have_http_status(:created)
    end

    it "completes the declaration" do
      expect(Declaration.find(outstanding_declaration)).to be_completed
    end

    it "sets the submission to unassigned" do
      expect(Submission.find(submission)).to be_unassigned
    end
  end

  xcontext "with an already completed declaration" do
    let(:declaration_id) { submission.declarations.completed.first.id }

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  xcontext "with an invalid declaration id" do
    let(:declaration_id) { "foo" }

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

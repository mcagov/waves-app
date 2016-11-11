require "rails_helper"

describe DeclarationOwnerController, type: :controller do
  before do
    sign_in create(:user)
  end

  let!(:submission) { create(:incomplete_submission) }
  let!(:declaration) { submission.declarations.first }

  context "#update" do
    before do
      put :update, params: {
        declaration_id: declaration.id,
        owner: { name: "John Doe", email: "jo@example.com" } }, xhr: true
    end

    it "updates the declaration" do
      expect(declaration.reload.owner.name).to eq("JOHN DOE")
    end

    it "does not upcase the email address" do
      expect(declaration.reload.owner.email).to eq("jo@example.com")
    end

    it "returns status 200" do
      expect(response).to have_http_status(200)
    end
  end
end

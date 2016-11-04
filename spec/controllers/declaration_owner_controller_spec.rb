require "rails_helper"

describe DeclarationOwnerController, type: :controller do
  before do
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  let!(:current_user) { create(:user) }
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

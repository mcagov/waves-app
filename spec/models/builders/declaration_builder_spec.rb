require "rails_helper"

describe Builders::DeclarationBuilder do
  context ".create" do
    before do
      Builders::DeclarationBuilder.create(
        create(:new_registration), [alice, bob], ["alice@example.com"])
    end

    let(:alice) { build(:declaration_owner, email: "alice@example.com") }
    let(:bob) { build(:declaration_owner) }
    let!(:submission) { Submission.last }

    it "has a completed declaration for alice" do
      expect(submission.declarations.completed.first.owner.name)
        .to eq(alice.name)
    end

    it "has an incomplete declaration for bob" do
      expect(submission.declarations.incomplete.first.owner.name)
        .to eq(bob.name)
    end

    it "does not build a notification for the completed declaration" do
      expect(submission.declarations.completed.first.notification)
        .to be_nil
    end

    it "builds a notification for the incomplete declaration" do
      expect(submission.declarations.incomplete.first.notification)
        .to be_a(Notification::OutstandingDeclaration)
    end
  end
end

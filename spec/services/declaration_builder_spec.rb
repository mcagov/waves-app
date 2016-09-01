require "rails_helper"

describe DeclarationBuilder do
  context ".build" do
    before do
      DeclarationBuilder.build(create(:submission), [alice, bob], [alice])
    end

    let(:alice) { "alice@example.com" }
    let(:bob) { "bob@example.com" }
    let!(:submission) { Submission.last }

    it "has a completed declaration for alice" do
      expect(submission.declarations.completed.first.owner_email).to eq(alice)
    end

    it "has an incomplete declaration for bob" do
      expect(submission.declarations.incomplete.first.owner_email).to eq(bob)
    end

    it "was declared_by alice" do
      expect(submission).to be_declared_by(alice)
    end

    it "was not declared_by bob" do
      expect(submission).not_to be_declared_by(bob)
    end

    it "does not build a notification for the completed declaration" do
      expect(submission.declarations.completed.first.notification).to be_nil
    end

    it "builds a OutstandingDeclaration notification for the incomplete declaration" do
      expect(submission.declarations.incomplete.first.notification).to be_a(Notification::OutstandingDeclaration)
    end
  end
end

require "rails_helper"

describe Builders::DeclarationBuilder do
  context ".create" do
    before do
      allow_any_instance_of(WavesUtilities::Task)
        .to receive(:declarations_required_on_create?)
        .and_return(declarations_required)

      Builders::DeclarationBuilder.create(
        create(:submission), [alice, bob], ["alice@example.com"])
    end

    let(:declarations_required) { true }
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

    context "when declarations are not required" do
      let(:declarations_required) { false }

      it "sets both declarations to not_required" do
        expect(submission.declarations.not_required.count).to eq(2)
      end

      it "does not build any notifications" do
        expect(Notification::OutstandingDeclaration.count).to eq(0)
      end
    end
  end
end

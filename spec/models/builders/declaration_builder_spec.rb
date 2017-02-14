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

    let(:alice) do
      build(:registered_owner, email: "alice@example.com", shares_held: 20)
    end

    let(:declarations_required) { true }
    let(:bob) { build(:registered_owner, entity_type: :corporate) }
    let!(:submission) { Submission.last }

    it "has a completed declaration for alice" do
      expect(submission.declarations.completed.first.owner.name)
        .to eq(alice.name)
    end

    it "has an incomplete declaration for bob" do
      expect(submission.declarations.incomplete.first.owner.name)
        .to eq(bob.name)
    end

    it "notes that alice is an individual owner" do
      expect(submission.declarations.first.entity_type.to_sym)
        .to eq(:individual)
    end

    it "notes that bob is a corporate owner" do
      expect(submission.declarations.last.entity_type.to_sym)
        .to eq(:corporate)
    end

    it "notes that alice owns 20 shares" do
      expect(submission.declarations.first.shares_held).to eq(20)
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

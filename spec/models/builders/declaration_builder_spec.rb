require "rails_helper"

describe Builders::DeclarationBuilder do
  context ".create" do
    before do
      allow_any_instance_of(WavesUtilities::Task)
        .to receive(:declarations_required_on_create?)
        .and_return(declarations_required)

      Builders::DeclarationBuilder.create(
        create(:submission, source: submission_source),
        [alice, bob],
        ["alice@example.com"],
        shareholder_groups)
    end

    let(:alice) do
      build(:registered_owner, name: "alice",
                               email: "alice@example.com",
                               shares_held: 20
           ).attributes.deep_symbolize_keys!
    end

    let(:bob) do
      build(:registered_owner, entity_type: :corporate
           ).attributes.deep_symbolize_keys!
    end

    let(:shareholder_groups) do
      [{ shares_held: 10, group_member_keys: ["alice;alice@example.com"] }]
    end

    let(:declarations_required) { true }
    let(:submission_source) { :online }
    let!(:submission) { Submission.last }

    let(:alice_declaration) do
      submission.declarations.find { |d| d.owner.name == alice[:name] }
    end

    let(:bob_declaration) do
      submission.declarations.find { |d| d.owner.name == bob[:name] }
    end

    it "has a completed declaration for alice" do
      expect(alice_declaration).to be_completed
    end

    it "has an incomplete declaration for bob" do
      expect(bob_declaration).to be_incomplete
    end

    it "notes that alice is an individual owner" do
      expect(alice_declaration.owner.entity_type.to_sym).to eq(:individual)
    end

    it "notes that bob is a corporate owner" do
      expect(bob_declaration.owner.entity_type.to_sym).to eq(:corporate)
    end

    it "notes that alice owns 20 shares" do
      expect(alice_declaration.shares_held).to eq(20)
    end

    it "does not build a notification for the completed declaration" do
      expect(submission.declarations.completed.first.notification).to be_nil
    end

    it "builds a notification for the incomplete declaration" do
      expect(submission.declarations.incomplete.first.notification)
        .to be_a(Notification::OutstandingDeclaration)
    end

    context "for a manual entry submission" do
      let(:submission_source) { :manual_entry }

      it "does not build any notifications" do
        expect(Notification::OutstandingDeclaration.count).to eq(0)
      end
    end

    context "declaration_groups" do
      let(:declaration_group) { submission.reload.declaration_groups.first }

      it "builds the declaration_group and assigns shares_held" do
        expect(declaration_group.shares_held).to eq(10)
      end

      it "adds declaration_group_member to the declaration_group" do
        group_member = declaration_group.declaration_group_members.first
        expect(group_member.declaration_owner.email).to eq("alice@example.com")
      end
    end

    context "when declarations are not required" do
      let(:declarations_required) { false }

      it "sets both declarations to not_required" do
        expect(submission.declarations.not_required.count)
          .to eq(submission.declarations.count)
      end

      it "does not build any notifications" do
        expect(Notification::OutstandingDeclaration.count).to eq(0)
      end
    end
  end
end

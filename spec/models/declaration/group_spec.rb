require "rails_helper"

describe Declaration::Group do
  context ".create" do
    let!(:submission) do
      create(:submission, declarations: [build(:declaration)])
    end

    let!(:declaration) { submission.declarations.first }

    subject do
      described_class.create(
        submission: submission, default_group_member: declaration.owner.id)
    end

    it "creates a Declaration::GroupMember for the default_group_member" do
      expect(subject.declaration_group_members.first.declaration_owner)
        .to eq(declaration.owner)
    end
  end
end

require "rails_helper"

describe Declaration::GroupMember do
  context ".destroy" do
    let!(:submission) { create(:unassigned_submission) }
    let!(:declaration) { submission.declarations.first }

    let!(:declaration_group) do
      Declaration::Group.create(
        submission: submission, default_group_member: declaration.id)
    end

    let!(:declaration_group_member) do
      declaration_group.declaration_group_members.last
    end

    context "with only one declaration_group_member" do
      it "deletes the declaration_group" do
        declaration_group_member.destroy
        expect(Declaration::Group.count).to eq(0)
      end
    end

    context "with more than one declaration_group_member" do
      before do
        Declaration::GroupMember.create(
          declaration: create(:declaration),
          declaration_group: declaration_group
        )
      end

      it "leaves the declaration_group intact" do
        declaration_group_member.destroy
        expect(Declaration::Group.last).to eq(declaration_group)
      end
    end
  end
end

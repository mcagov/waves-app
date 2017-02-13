require "rails_helper"

describe Declaration do
  context ".destroy" do
    let!(:submission) { create(:unassigned_submission) }
    let!(:declaration) { submission.declarations.first }

    context "with membership of a declaration_group" do
      before do
        Declaration::Group.create(
          submission: submission, default_group_member: declaration.id)
        declaration.destroy
      end

      it "removes the declaration_group_member" do
        expect(Declaration::GroupMember.count).to eq(0)
      end
    end
  end
end

require "rails_helper"

describe Policies::Workflow do
  context "#approved_name_required?" do
    let(:submission) { create(:submission, part: part) }

    subject { described_class.approved_name_required?(submission) }

    context "for part_3" do
      let(:part) { :part_3 }

      it { expect(subject).to be_falsey }
    end

    context "for part_1" do
      let(:part) { :part_1 }

      it { expect(subject).to be_truthy }
    end

    context "for part_2" do
      let(:part) { :part_2 }

      it { expect(subject).to be_truthy }

      context "when the submission is for an existing vessel" do
        let(:submission) do
          create(:unassigned_change_vessel_submission, part: :part_2)
        end

        it { expect(subject).to be_falsey }
      end

      context "when the submission has a name_approval" do
        let(:submission) { create(:submission_name_approval).submission }

        it { expect(subject).to be_falsey }
      end
    end
  end

  context "#generate_official_no?" do
    let(:submission) { create(:submission, part: part) }

    subject { described_class.generate_official_no?(submission) }

    context "for part_3" do
      let(:part) { :part_3 }

      it { expect(subject).to be_falsey }
    end

    context "for part_2" do
      let(:part) { :part_2 }

      it { expect(subject).to be_truthy }
    end
  end

  context ".uses_port_no?" do
    subject { described_class.uses_port_no?(vessel) }

    context "for a fishing vessel" do
      let(:vessel) { build(:fishing_vessel) }

      it { expect(subject).to be_truthy }
    end

    context "for a pleasure vessel" do
      let(:vessel) { build(:pleasure_vessel) }

      it { expect(subject).to be_falsey }
    end
  end
end

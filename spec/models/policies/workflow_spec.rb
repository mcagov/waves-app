require "rails_helper"

describe Policies::Workflow do
  context "#approved_name_required?" do
    subject { described_class.approved_name_required?(submission) }

    context "for part_3" do
      let(:submission) { create(:submission, part: :part_3) }

      it { expect(subject).to be_falsey }
    end

    context "for part_1" do
      let(:submission) { create(:submission, part: :part_1) }

      it { expect(subject).to be_truthy }
    end

    context "when the submission is for an existing vessel" do
      let(:submission) { create(:submission, :part_2_vessel) }

      it { expect(subject).to be_falsey }
    end

    context "when the submission has a name_approval" do
      let(:submission) { create(:name_approval).submission }

      it { expect(subject).to be_falsey }
    end

    # On the name approval page, the submission object might have an
    # associated name approval object that is used by the form builder.
    # Here we ensure that this temporary object is not treated as a
    # persisted one
    context "when the submission has a name_approval that is not persisted" do
      let(:submission) { build(:name_approval).submission }

      it { expect(subject).to be_truthy }
    end
  end

  context "#generate_official_no?" do
    let!(:submission) { create(:submission, part: part) }

    subject { described_class.generate_official_no?(submission) }

    context "for part_3" do
      let(:part) { :part_3 }

      it { expect(subject).to be_falsey }
    end

    context "for part_2" do
      let(:part) { :part_2 }

      before do
        allow(Policies::Workflow)
          .to receive(:approved_name_required?)
          .with(submission)
          .and_return(approved_name_required)
      end

      context "and approved_name is not required" do
        let(:approved_name_required) { false }

        it { expect(subject).to be_truthy }
      end

      context "and approved_name is not required" do
        let(:approved_name_required) { true }

        it { expect(subject).to be_falsey }
      end
    end
  end

  describe "#can_edit_official_number?" do
    subject { described_class.can_edit_official_number?(user) }

    context "as a system_manager" do
      let(:user) { build(:system_manager) }

      it { expect(subject).to be_truthy }
    end

    context "as an operational_user" do
      let(:user) { build(:user) }

      it { expect(subject).to be_falsey }
    end
  end

  describe "#can_scrub_vessel_details?" do
    subject { described_class.can_scrub_vessel_details?(user) }

    context "as a system_manager" do
      let(:user) { build(:system_manager) }

      it { expect(subject).to be_truthy }
    end

    context "as an operational_user" do
      let(:user) { build(:user) }

      it { expect(subject).to be_falsey }
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

  context ".uses_csr_forms?" do
    subject { described_class.uses_csr_forms?(vessel) }

    context "for a part_1 vessel" do
      let(:vessel) { build(:registered_vessel, part: :part_1) }

      it { expect(subject).to be_truthy }
    end

    context "for a fishing vessel" do
      let(:vessel) { build(:part_4_fishing_vessel) }

      it { expect(subject).to be_falsey }
    end

    context "for a part 3 vessel" do
      let(:vessel) { build(:unregistered_vessel, part: :part_3) }

      it { expect(subject).to be_falsey }
    end
  end

  context ".uses_vessel_attribute?" do
    before do
      expect(WavesUtilities::Vessel)
        .to receive(:attributes_for)
        .with(:part_4, true).and_return([:name, :port_no])
    end

    let(:vessel) { build(:part_4_fishing_vessel) }
    subject { described_class.uses_vessel_attribute?(attr, vessel) }

    context "when the attribute is in use for this vessel" do
      let(:attr) { :name }
      it { expect(subject).to be_truthy }
    end

    context "when the attribute is NOT in use for this vessel" do
      let(:attr) { :foo }
      it { expect(subject).to be_falsey }
    end
  end

  context ".uses_editable_registration_type?" do
    let(:submission) { create(:submission, part: part) }

    subject { described_class.uses_editable_registration_type?(submission) }

    context "for part_1" do
      let(:part) { :part_1 }

      it { expect(subject).to be_falsey }
    end

    context "for part_2" do
      let(:part) { :part_2 }

      it { expect(subject).to be_truthy }
    end
  end

  context ".uses_extended_engines?" do
    subject { described_class.uses_extended_engines?(vessel) }

    context "for a fishing vessel" do
      let(:vessel) { build(:fishing_vessel) }

      it { expect(subject).to be_truthy }
    end

    context "for a pleasure vessel" do
      let(:vessel) { build(:pleasure_vessel) }

      it { expect(subject).to be_falsey }
    end
  end

  context ".uses_extended_owners?" do
    subject { described_class.uses_extended_owners?(vessel) }

    context "for a fishing vessel" do
      let(:vessel) { build(:fishing_vessel) }

      it { expect(subject).to be_truthy }
    end

    context "for a pleasure vessel" do
      let(:vessel) { build(:pleasure_vessel) }

      it { expect(subject).to be_falsey }
    end
  end

  context ".uses_shareholding?" do
    let(:vessel) { build(:registered_vessel, part: part) }
    subject { described_class.uses_shareholding?(vessel) }

    context "for a part_4 vessel" do
      let(:part) { :part_4 }

      it { expect(subject).to be_falsey }
    end

    context "for a part_1 vessel" do
      let(:part) { :part_1 }

      it { expect(subject).to be_truthy }
    end
  end
end

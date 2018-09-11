require "rails_helper"
include CollectionHelper

describe CollectionHelper, type: :helper do
  describe "#propulsion_system_collection" do
    let(:default_collection) { WavesUtilities::PropulsionSystem.all }
    subject { helper.propulsion_system_collection(appendable_item) }

    context "with no appendable_item" do
      let(:appendable_item) { nil }

      it { expect(subject).to eq(default_collection) }
    end

    context "with a appendable_item that is already in the collection" do
      let(:appendable_item) { "Sail" }

      it { expect(subject).to eq(default_collection) }
    end

    context "with a appendable_item that is not in the collection" do
      let(:appendable_item) { "Fins" }

      it { expect(subject).to eq(default_collection << "Fins") }
    end
  end

  describe "#available_priority_codes_collection" do
    let(:default_collection) { ("A".."Z").to_a }
    let!(:submission) { create(:submission) }
    let(:mortgage) { Mortgage.new }

    subject do
      helper.available_priority_codes_collection(submission, mortgage)
    end

    context "with no mortgages" do
      it { expect(subject).to eq(default_collection) }
    end

    context "with two mortgages" do
      let!(:mortgage_a) do
        create(:mortgage, priority_code: "A", parent: submission)
      end

      before do
        create(:mortgage, priority_code: "B", parent: submission)
      end

      it { expect(subject).to eq(default_collection - %w(A B)) }

      context "building the list for mortgage_a" do
        let(:mortgage) { mortgage_a }

        it { expect(subject).to eq(default_collection - %w(B)) }
      end
    end
  end

  describe "email_recipient_select_options" do
    let(:submission) { build(:submission, applicant_name: "ALICE") }

    let(:alice) { double(:applicant, name: "alice", email: "foo") }
    let(:bob) { double(:owner, name: "bob", email: "foo") }
    let(:charlie) { double(:charter_party, name: "charlie", email: "foo") }
    let(:dave) { double(:owner, name: "", email: "foo") }
    let(:eric) { double(:owner, name: "eric", email: "") }

    before do
      allow(submission).to receive(:applicant).and_return(alice)
      allow(submission).to receive(:owners).and_return([bob, dave])
      allow(submission).to receive(:charter_parties).and_return([charlie])
    end

    subject { helper.email_recipient_select_options(submission) }

    it { expect(subject).to eq([alice, bob, charlie]) }
  end
end

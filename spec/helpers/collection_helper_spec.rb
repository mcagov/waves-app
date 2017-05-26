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
    subject { helper.available_priority_codes_collection(submission) }

    context "with no mortgages" do
      it { expect(subject).to eq(default_collection) }
    end

    context "with two mortgages" do
      before do
        create(:mortgage, priority_code: "A", parent: submission)
        create(:mortgage, priority_code: "B", parent: submission)
      end

      it { expect(subject).to eq(default_collection - %w(A B)) }
    end
  end
end

require "rails_helper"

describe Declaration::Owner do
  context "#individual?" do
    subject { described_class.new(entity_type: entity_type).individual? }

    context "by default" do
      let(:entity_type) { nil }

      it { expect(subject).to be_truthy }
    end

    context "for a corporate owner" do
      let(:entity_type) { :corporate }

      it { expect(subject).to be_falsey }
    end
  end
end

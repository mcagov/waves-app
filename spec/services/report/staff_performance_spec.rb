require "rails_helper"

describe Report::StaffPerformance do
  context "in general" do
    subject { described_class.new }

    it { expect(subject.title).to eq("Staff Performance") }
  end
end

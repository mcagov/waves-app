require "rails_helper"

describe Submission::NameApproval do
  let(:name_approval) do
    described_class.new(
      part: :part_2,
      name: "BOBS BOAT",
      port_code: "SU",
      port_no: 1234)
  end

  context "#valid?" do
    before do
      expect(VesselNameValidator)
        .to receive(:valid?).with("part_2", "BOBS BOAT", "SU")

      expect(VesselPortNoValidator)
        .to receive(:valid?).with("part_2", 1234, "SU")
    end

    it { name_approval.valid? }
  end

  context ".port_name" do
    it { expect(name_approval.port_name).to eq("SOUTHAMPTON") }
  end
end

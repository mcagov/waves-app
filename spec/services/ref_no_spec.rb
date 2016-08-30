require "rails_helper"

describe RefNo do
  let(:ref_no) { RefNo.generate("00") }

  it "generates a nine character ref_no" do
    expect(ref_no.length).to eq(9)
  end

  it "has the input prefix" do
    expect(ref_no).to match(/^00-.*/)
  end

  context "in the unlikely event of a duplicate" do
    before do
      expect(SecureRandom).to receive(:hex).with(3).and_return("123456", "ABCDEF").twice
      expect(Submission).to receive(:where).with(ref_no: "00-123456").and_return(["foo"]).once
      expect(Submission).to receive(:where).with(ref_no: "00-ABCDEF").and_return([]).once
    end

    it { expect(ref_no).to be_present }
  end
end

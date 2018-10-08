require "rails_helper"

describe RefNo do
  context "in general" do
    subject { described_class.generate }

    context "in general" do
      it "generates a six character ref_no" do
        expect(subject.length).to eq(6)
      end

      context "in the unlikely event of a duplicate" do
        before do
          expect(SecureRandom).to receive(:hex).with(3)
            .and_return("123456", "ABCDEF").twice
          expect(Submission).to receive(:where).with(ref_no: "123456")
            .and_return(["foo"]).once
          expect(Submission).to receive(:where).with(ref_no: "ABCDEF")
            .and_return([]).once
        end

        it { expect(subject.length).to eq(6) }
      end
    end
  end

  context ".parse" do
    subject { described_class.parse(input) }

    context "with a task ref_no" do
      let(:input) { "123456/1" }

      it { expect(subject).to eq("123456") }
    end

    context "with a submission ref_no" do
      let(:input) { "123456" }

      it { expect(subject).to eq("123456") }
    end

    context "with nothing" do
      let(:input) { nil }

      it { expect(subject).to be_nil }
    end
  end
end

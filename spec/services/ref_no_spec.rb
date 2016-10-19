require "rails_helper"

describe RefNo do
  let!(:submission) do
    build(:submission, part: part, task: task)
  end

  subject { described_class.generate_for(submission) }

  context "for :part_1 :new_registration" do
    let(:part) { :part_1 }
    let(:task) { :new_registration }

    it "generates a nine character ref_no" do
      expect(subject.length).to eq(9)
    end

    it "has the input prefix" do
      expect(subject).to match(/^1N-.*/)
    end

    context "in the unlikely event of a duplicate" do
      before do
        expect(SecureRandom).to receive(:hex).with(3)
          .and_return("123456", "ABCDEF").twice
        expect(Submission).to receive(:where).with(ref_no: "1N-123456")
          .and_return(["foo"]).once
        expect(Submission).to receive(:where).with(ref_no: "1N-ABCDEF")
          .and_return([]).once
      end

      it { expect(subject).to be_present }
    end
  end

  context "for :part_3 :unkown" do
    let(:part) { :part_3 }
    let(:task) { :unknown }

    it "has the input prefix" do
      expect(subject).to match(/^3X-.*/)
    end
  end

  context "for :part_3 :foo" do
    let(:part) { :part_3 }
    let(:task) { :foo }

    it "has the input prefix" do
      expect(subject).to match(/^3X-.*/)
    end
  end
end

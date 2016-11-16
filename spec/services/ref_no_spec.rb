require "rails_helper"

describe RefNo do
  context "in general" do
    let!(:submission) { build(:submission) }

    subject { described_class.generate_for(submission) }

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

    context "when officer_intervention_required" do
      before do
        submission.officer_intervention_required = true
      end

      it "does not generate a ref_no" do
        expect(subject).to be_blank
      end
    end
  end
end

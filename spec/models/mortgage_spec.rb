require "rails_helper"

describe Mortgage do
  context ".types_for(submission)" do
    subject { described_class.types_for(submission) }

    context "when the submission is for a new_registration" do
      let(:submission) { build(:submission) }

      it { expect(subject).to eq(["Intent"]) }
    end

    context "when the submission is for a provisional registratioschemn" do
      let(:submission) { build(:submission, task: :provisional) }

      it { expect(subject).to eq(["Intent"]) }
    end

    context "when the submission is not a new_registration" do
      let(:submission) { build(:submission, task: :change_vessel) }

      it do
        expect(subject).to eq(["Intent", "Account Current", "Principle Sum"])
      end
    end
  end

  context "#register!" do
    let(:mortgage) do
      create(:mortgage, registered_at: registered_at,
                        mortgage_type: mortgage_type).register!("21/11/2012")
    end

    context "when the mortgage has not been registered" do
      let(:registered_at) { nil }

      context "with a mortgage of intent" do
        let(:mortgage_type) { "Intent" }

        it { expect(mortgage.registered_at).to be_blank }
      end

      context "with a current account mortgage" do
        let(:mortgage_type) { "Current Account" }

        it { expect(mortgage.registered_at).to eq("21/11/2012") }
      end

      context "with a principle sum mortgage" do
        let(:mortgage_type) { "Principle Sum" }

        it { expect(mortgage.registered_at).to eq("21/11/2012") }
      end
    end

    context "when the mortgage has already been registered" do
      let(:registered_at) { "14/04/2011" }

      context "with a mortgage of intent" do
        let(:mortgage_type) { "Intent" }

        it { expect(mortgage.registered_at).to be_blank }
      end

      context "with a current account mortgage" do
        let(:mortgage_type) { "Current Account" }

        it do
          expect(mortgage.registered_at.to_date).to eq("14/04/2011".to_date)
        end
      end
    end
  end
end

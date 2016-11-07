require "rails_helper"

describe RegistrationDate do
  context ".for" do
    subject { described_class.for(submission) }

    context "a new_registration" do
      let(:submission) { build(:submission) }

      it "sets starts_at to today" do
        expect(subject.starts_at.to_date).to eq(Date.today)
      end
    end

    context "a renewal" do
      let(:submission) { build(:submission, task: :renewal) }

      before do
        registered_vessel =
          double(:registered_vessel, registered_until: 1.month.from_now)

        allow(submission)
          .to receive(:registered_vessel)
          .and_return(registered_vessel)
      end

      it "sets starts_at to the expiry of latest_registration" do
        expect(subject.starts_at.to_date).to eq(1.month.from_now.to_date)
      end
    end
  end
end

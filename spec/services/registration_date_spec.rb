require "rails_helper"

describe RegistrationDate do
  context ".for" do
    subject { described_class.for(submission, "2012-11-24") }

    context "new registration" do
      let(:submission) { build(:submission) }

      it "sets starts_at to today" do
        expect(subject.starts_at.to_date).to eq(Date.new(2012, 11, 24))
      end

      it "sets ends_at to 5 years ahead" do
        expect(subject.ends_at.to_date).to eq(Date.new(2017, 11, 24))
      end
    end

    context "a provisional_registration" do
      let(:submission) { build(:submission, task: :provisional) }

      it "sets starts_at to today" do
        expect(subject.starts_at.to_date).to eq(Date.new(2012, 11, 24))
      end

      it "sets ends_at to 90 days ahead" do
        expect(subject.ends_at.to_date).to eq(Date.new(2013, 2, 22))
      end
    end
  end
end

require "rails_helper"

describe Submission::Closure do
  context "#actioned_at" do
    let(:closure) { Submission::Closure.new(params) }
    subject { closure.actioned_at }

    context "with a valid set of date params" do
      let(:params) do
        { actioned_day: "23", actioned_month: "6", actioned_year: "2016" }
      end

      it { expect(subject).to eq("2016-06-23".to_date) }
    end

    context "with invalid date params" do
      let(:params) do
        { actioned_day: "23", actioned_month: "16", actioned_year: "2016" }
      end

      it { expect(subject).to be_blank }
    end

    context "with no date params" do
      let(:params) { {} }

      it { expect(subject).to be_blank }
    end
  end
end

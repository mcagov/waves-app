require "rails_helper"

describe Policies::Rules do
  context ".issues_csr?" do
    let(:task) { create(:submission_task, service: service) }

    subject { described_class.issues_csr?(task) }

    context "when the rule is defined" do
      let(:service) { create(:service, :issues_csr) }

      it { expect(subject).to be_truthy }
    end

    context "when the rule is not defined" do
      let(:service) { create(:service) }

      it { expect(subject).to be_falsey }
    end
  end
end

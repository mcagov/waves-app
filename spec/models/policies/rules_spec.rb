require "rails_helper"

describe Policies::Rules do
  context "checking to see if a rule is enforced" do
    let(:task) { create(:submission_task, service: service) }

    subject { described_class.new(task).issues_csr }

    context "when the rule 'issues_csr' is defined" do
      let(:service) { create(:service, :issues_csr) }

      it { expect(subject).to be_truthy }
    end

    context "when the rule is not defined" do
      let(:service) { create(:service) }

      it { expect(subject).to be_falsey }
    end
  end
end

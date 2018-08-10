require "rails_helper"

describe Policies::Activities do
  context "checking to see if an activity occurs" do
    let(:task) { create(:submission_task, service: service) }

    subject { described_class.new(task).generate_provisional_registration }

    context "when 'generate_provisional_registration' is defined" do
      let(:service) { create(:service, :generate_provisional_registration) }

      it { expect(subject).to be_truthy }
    end

    context "when 'generate_provisional_registration' is not defined" do
      let(:service) { create(:service) }

      it { expect(subject).to be_falsey }
    end
  end
end

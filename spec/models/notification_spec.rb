require "rails_helper"

describe Notification, type: :model do
  subject { described_class.new }

  context "#create" do
    it "has status: queued" do
      expect(subject).to be_queued
    end
  end

  context "#deliver!" do
    before do
      subject.deliver!
    end

    it "has status: delivered" do
      expect(subject).to be_delivered
    end

    it "creates a delayed job" do
      expect(Delayed::Job.count).to eq(1)
    end
  end
end

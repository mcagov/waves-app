require "rails_helper"

describe Notification, type: :model do
  subject { described_class.new }

  context "#create" do
    it "has status: undelivered" do
      expect(subject).to be_undelivered
    end
  end

  context "#send_to_queue!" do
    before do
      subject.send_to_queue!
    end

    it "has status: queued" do
      expect(subject).to be_queued
    end

    it "creates a delayed job" do
      expect(Delayed::Job.count).to eq(1)
    end
  end
end

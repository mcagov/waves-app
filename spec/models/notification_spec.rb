require "rails_helper"

describe Notification, type: :model do
  subject { described_class.new }

  context "#create" do
    it "is undelivered" do
      expect(subject).to be_undelivered
    end
  end

  context "#send_to_queue!" do
    before do
      dj = double("delayed_job", send_email: "something")
      expect(NotificationMailer).to receive(:delay).with(dj).once

      subject.send_to_queue!
    end

    it "is queued" do
      expect(subject).to be_queued
    end
  end
end

require "rails_helper"

describe Notification, type: :model do
  subject { described_class.new }

  context "#create" do
    it "is undelivered" do
      expect(subject).to be_undelivered
    end
  end

  context "#send_to_queue!" do
    before { subject.send_to_queue! }

    it "invokes the mailer"

    it "is queued" do
      expect(subject).to be_queued
    end
  end
end

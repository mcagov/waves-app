require "rails_helper"
include SubmissionHelper

describe "SubmissionHelper", type: :helper do
  describe "#css_tick" do
    it "shows the green tick" do
      expect(helper.css_tick(true)).to match(/i fa fa-check green/)
    end

    it "shows the red cross" do
      expect(helper.css_tick(false)).to match(/i fa fa-times red/)
    end
  end

  describe "#correspondence_notifications" do
    let!(:submission) { create(:submission) }

    let!(:old_notification) do
      create(:notification, notifiable: submission, created_at: 1.year.ago)
    end

    let!(:recent_notification) do
      create(:notification, notifiable: submission, created_at: 1.day.ago)
    end

    let!(:correspondence) do
      create(:correspondence, noteable: submission, created_at: 3.days.ago)
    end

    it "builds a list" do
      expect(helper.correspondence_notifications(submission)).to eq(
        [recent_notification, correspondence, old_notification]
      )
    end
  end
end

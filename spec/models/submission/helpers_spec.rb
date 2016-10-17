require "rails_helper"

describe "Submission Helpers", type: :model do
  context "#notification_list" do
    let!(:submission) { create(:submission) }

    let!(:outstanding_declaration) do
      create(
        :notification,
        notifiable: create(:declaration, submission: submission),
        created_at: Date.today)
    end

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
      expect(submission.notification_list).to eq(
        [outstanding_declaration,
         recent_notification, correspondence, old_notification]
      )
    end
  end
end

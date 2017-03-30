require "rails_helper"

describe Builders::NotificationListBuilder do
  context "#for_submission" do
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

    subject { described_class.for_submission(submission) }

    it "builds the expected list" do
      expect(subject).to eq(
        [outstanding_declaration,
         recent_notification, correspondence, old_notification]
      )
    end

    context "#for_registered_vessel" do
      let!(:vessel) { create(:registered_vessel) }

      let!(:vessel_notification) do
        create(:notification, notifiable: vessel, created_at: 1.minute.ago)
      end

      let!(:vessel_correspondence) do
        create(:correspondence, noteable: vessel, created_at: 1.hour.ago)
      end

      before do
        submission.update_attribute(:registered_vessel_id, vessel.id)
      end

      subject { described_class.for_registered_vessel(vessel) }

      it "builds the expected list" do
        expect(subject).to eq(
          [vessel_notification, vessel_correspondence, outstanding_declaration,
           recent_notification, correspondence, old_notification]
        )
      end
    end
  end
end

require "rails_helper"

describe "Manager approves system-generated notifications" do
  before do
    @submission = create(:submission)
    @registered_vessel = create(:registered_vessel)

    Notification::CarvingAndMarkingReminder.create(
      recipient_name: "Bob",
      recipient_email: "bob@example.com",
      notifiable: @submission)

    Notification::RenewalReminder.create(
      recipient_name: "Alice",
      recipient_email: "alice@example.com",
      notifiable: @registered_vessel)

    login_as_system_manager
    click_on("Automated Email Queue")
  end

  scenario "in general" do
    within(all(".notification")[0]) do
      expect(page)
        .to have_link(
          @submission.ref_no,
          href: submission_path(@submission))

      expect(page).to have_text("Bob <bob@example.com>")
      expect(page).to have_text("Carving & Marking Reminder:")
    end

    within(all(".notification")[1]) do
      expect(page)
        .to have_link(
          @registered_vessel.to_s,
          href: vessel_path(@registered_vessel))

      expect(page).to have_text("Alice <alice@example.com>")
      expect(page).to have_text("Registration Renewal Reminder:")
    end
  end

  scenario "approving the queue" do
    click_on("Approve & Send 2 Email")

    expect(page).to have_text("The automated email queue is being processed.")
  end
end

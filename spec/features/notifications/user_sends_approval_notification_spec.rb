require "rails_helper"

describe "User sends application approval notification", js: true do
  before do
    visit_claimed_task
  end

  scenario "in general" do
    within("#application-tools") { click_on("Application Approval Email") }

    within(".modal.fade.in") do
      expect(find_field("notification_application_approval[subject]").value)
        .to eq("UK ship registry, reference no: #{@submission.ref_no}")

      find_field("notification_application_approval[subject]").set("Hello")
      check(@submission.applicant.email_description)
      check(@submission.owners.first.email_description)

      find("trix-editor").click.set("The message")

      click_on("Send")
    end

    expect(page)
      .to have_text("Emails have been sent to the selected recipients")

    notification =
      Notification.find_by(recipient_email: @submission.applicant_email)

    expect(notification.recipient_name).to eq(@submission.applicant_name)
    expect(notification.subject).to eq("Hello")
    expect(notification.body).to match(/The message/)

    expect(Notification::ApplicationApproval.count).to eq(2)
  end

  scenario "with attachments"
end

require "rails_helper"

feature "User adds a new registration", type: :feature do
  before do
    login_to_part_3
    visit new_submission_path

    select("New Registration", from: "Application Type")
    fill_in("Vessel Name", with: "MY BOAT")

    fill_in("Date Document Received", with: "1/1/2016")
    fill_in("Applicant Name", with: "Bob")
    fill_in("Applicant's Email Address", with: "bob@example.com")
  end

  scenario "with an application receipt email" do
    check("Send an Application Receipt email")
    click_on("Save Application")

    expect(page).to have_css("h1", text: "New Registration ID: ")
    expect(page).to have_css("td.vessel-name", text: "MY BOAT")

    expect(Notification::ApplicationReceipt.last.recipient_email)
      .to eq("bob@example.com")
    expect(page)
      .to have_text("An Application Receipt has been sent to bob@example.com")
  end

  scenario "without an application receipt email" do
    click_on("Save Application")
    expect(page).to have_css("h1", text: "New Registration ID: ")
    expect(Notification::ApplicationReceipt.last).to be_nil
  end

  scenario "when the applicant is an agent" do
    check("Applicant is Agent")
    click_on("Save Application")

    expect(Submission.last.agent.name).to eq("Bob")
  end
end

require "rails_helper"

feature "User views print queues", type: :feature, js: true do
  before do
    login_to_part_1
    visit "/print_queue/registration_certificate"
  end

  scenario "viewing print queues" do
    click_on("Carving & Marking Notes")
    expect(page)
      .to have_css("h1", text: "Print Queue: Carving & Marking Notes")

    click_on("Certificates of Registry")
    expect(page)
      .to have_css("h1", text: "Print Queue: Certificates of Registry")

    click_on("Cover Letters")
    expect(page)
      .to have_css("h1", text: "Print Queue: Cover Letters")

    click_on("Cover Letters: Closure Without Notice")
    expect(page)
      .to have_css(
        "h1", text: "Print Queue: Cover Letters: Closure Without Notice")

    click_on("Current Transcripts")
    expect(page)
      .to have_css("h1", text: "Print Queue: Current Transcripts")

    click_on("Historic Transcripts")
    expect(page)
      .to have_css("h1", text: "Print Queue: Historic Transcripts")

    click_on("Mortgagee Reminder Letters")
    expect(page)
      .to have_css("h1", text: "Print Queue: Mortgagee Reminder Letters")

    click_on("Provisional Certificates")
    expect(page)
      .to have_css("h1", text: "Print Queue: Provisional Certificates")

    click_on("Renewal Reminder Letters")
    expect(page)
      .to have_css("h1", text: "Print Queue: Renewal Reminder Letters")

    click_on("7 Day Notices of Termination")
    expect(page)
      .to have_css("h1", text: "Print Queue: 7 Day Notices of Termination")

    click_on("30 Day Section Notices")
    expect(page)
      .to have_css("h1", text: "Print Queue: 30 Day Section Notices")
  end
end

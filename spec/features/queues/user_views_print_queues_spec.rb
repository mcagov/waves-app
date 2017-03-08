require "rails_helper"

feature "User views print queues", type: :feature, js: true do
  before do
    login_to_part_3
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

    click_on("Current Transcripts")
    expect(page)
      .to have_css("h1", text: "Print Queue: Current Transcripts")

    click_on("Historic Transcripts")
    expect(page)
      .to have_css("h1", text: "Print Queue: Historic Transcripts")
  end
end

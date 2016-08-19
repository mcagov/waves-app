require "rails_helper"

feature "User views task lists", type: :feature, js: true do
  before { login }

  scenario "viewing task lists" do
    click_link('My Tasks')
    expect(page).to have_css('h1', text: 'My Tasks')

    click_link('Team Tasks')
    expect(page).to have_css('h1', text: 'Team Tasks')

    click_link('Unclaimed Tasks')
    expect(page).to have_css('h1', text: 'Unclaimed Tasks')

    click_link('Print Queue')
    expect(page).to have_css('h1', text: 'Print Queue')

    click_link('Referred Applications')
    expect(page).to have_css('h1', text: 'Referred Applications')

    click_link('Incomplete Applications')
    expect(page).to have_css('h1', text: 'Incomplete Applications')
  end

  scenario "moving a submission between lists" do
    submission = create_paid_submission!

    visit tasks_unclaimed_path
    expect(page).to have_css('tr.submission')

  end
end

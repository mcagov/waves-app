require "rails_helper"

feature "User views task lists", type: :feature, js: true do
  before do
    create_paid_submission!
    login
  end

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
    click_link('Unclaimed Tasks')

    # claim task and redirect to my tasks
    within('tr.submission') { click_on("Claim") }
    expect(page).to have_css('h1', text: 'My Tasks')


    # unclaim task and redirect (return) to my tasks
    within('tr.submission') { click_on("Unclaim") }
    expect(page).to have_css('h1', text: 'My Tasks')
    expect(page).not_to have_css('tr.submission')
  end

  scenario "viewing tasks assigned to other team members"
end

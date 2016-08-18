require "rails_helper"

feature "User toggles the sidebar", type: :feature, js: true do
  before { login }

  scenario "viewing tasks" do
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
end

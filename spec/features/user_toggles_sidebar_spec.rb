require "rails_helper"

feature "User toggles the sidebar", type: :feature, javascript: true do
  before { login }

  scenario do
    visit "/"
    save_and_open_page
    click_link('My Tasks')
    expect(page).to have_css('h1', 'My Tasks')

    click_link('Unclaimed Tasks')
    expect(page).to have_css('h1', 'Unclaimed Tasks')

    click_link('Print Queue')
    expect(page).to have_css('h1', 'Print Queue')

    click_link('Referred Applications')
    expect(page).to have_css('h1', 'Referred Applications')

    click_link('Incomplete Applications')
    expect(page).to have_css('h1', 'Incomplete Applications')
  end
end

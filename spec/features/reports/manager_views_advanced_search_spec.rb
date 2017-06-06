require "rails_helper"

describe "Manager views advanced search", js: true do
  scenario "in general" do
    login_to_reports
    click_on("Advanced Search")

    find_field("filter[vessel[name_operator]]").select("exclude")
    find_field("filter[vessel][name]").set("Bob")
    click_on("Apply Filter")

    expect(find_field("filter[vessel[name_operator]]").value).to eq("excludes")
    expect(find_field("filter[vessel][name]").value).to eq("Bob")
  end
end

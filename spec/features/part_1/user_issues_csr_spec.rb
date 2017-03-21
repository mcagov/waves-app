require "rails_helper"

describe "User issues CSR", js: true do
  scenario "in general" do
    visit_assigned_csr_submission

    expect(find("#csr_form_vessel_name").value).to eq("Registered Boat 1")
    find("#csr_form_remarks").set("NO COMMENT")
    click_on("Save Details")

    expect(page)
      .to have_link("Go to Task List", href: tasks_my_tasks_path)

    expect(CsrForm.last.remarks).to eq("NO COMMENT")

    click_on("Issue CSR")
    click_on("Approve & Issue CSR")
  end
end

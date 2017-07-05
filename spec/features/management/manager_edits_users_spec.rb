require "rails_helper"

describe "Manager edits users" do
  before do
    login_as_system_manager
    click_on("User Management")
  end

  xscenario "adding a user" do
    click_on("New User")
  end
end

require "rails_helper"

describe "User views work logs" do
  before do
    3.times { create(:work_log, part: part) }
    login_to_part_3
  end
end

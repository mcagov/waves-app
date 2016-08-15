def login
  visit root_path(as: create(:user))
end

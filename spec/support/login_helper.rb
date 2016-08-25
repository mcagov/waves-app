def login(user=create(:user))
  visit root_path(as: user)
end

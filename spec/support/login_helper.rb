def login(user = create(:user))
  visit root_path(as: user)
end

def login_to_part_3(user = create(:user))
  login(user)
  click_on("Part 3")
end

def login_to_finance(user = create(:user))
  login(user)
  click_on("Finance Team")
end

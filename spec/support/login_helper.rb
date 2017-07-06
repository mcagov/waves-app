def login(user = create(:user), part = :part_3)
  sign_in user
  page.set_rack_session(current_activity: part)
end

def login_to_part_1(user = create(:user))
  login(user, :part_1)
  visit "/tasks/my-tasks"
end

def login_to_part_2(user = create(:user))
  login(user, :part_2)
  visit "/tasks/my-tasks"
end

def login_to_part_3(user = create(:user))
  login(user, :part_3)
  visit "/tasks/my-tasks"
end

def login_to_part_4(user = create(:user))
  login(user, :part_4)
  visit "/tasks/my-tasks"
end

def login_to_finance(user = create(:user))
  login(user, :finance)
  visit "/finance/batches"
end

def login_to_reports(user = create(:system_manager))
  login(user, :reports)
  visit "/admin/reports/staff_performance"
end

def login_as_system_manager(user = create(:system_manager))
  login(user, :part_1)
  visit "/tasks/my-tasks"
end

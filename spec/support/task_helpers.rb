def visit_claimed_task(service: nil, submission: nil)
  @submission = submission || create(:submission)
  create(:payment, submission: @submission)
  @service = service || create(:demo_service)
  @task = create(:claimed_task, submission: @submission, service: @service)

  login_to_part_3(@task.claimant)
  visit submission_task_path(@submission, @task)
end

def expect_task_to_be_active
  expect(page).to have_css(".bg-green")
end

def expect_application_info_panel
  expect(page).to have_css("#application-info")
end

def expect_application_tasks_panel
  expect(page).to have_css("#application-tasks")
end

def expect_task_actions
  expect(page).to have_css("#actions")
end

def visit_claimed_task(service: nil, submission: nil)
  @submission = submission || create(:submission)
  create(:payment, submission: @submission)
  @service = service || create(:demo_service)
  @task = create(:claimed_task, submission: @submission, service: @service)

  login(@task.claimant, @submission.part)
  visit submission_task_path(@submission, @task)
end

def visit_completed_task(service: nil, submission: nil)
  @submission = submission || create(:submission)
  create(:payment, submission: @submission)
  @service = service || create(:demo_service)
  @task = create(:completed_task, submission: @submission, service: @service)

  login(@task.claimant, @submission.part)
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

def visit_claimed_task(service: nil, submission: nil)
  @submission = submission || create(:submission)
  create(:payment, submission: @submission)
  @service = service || create(:demo_service)
  @task = create(:claimed_task, submission: @submission, service: @service)

  login_to_part_3(@task.claimant)
  visit submission_task_path(@submission, @task)
end

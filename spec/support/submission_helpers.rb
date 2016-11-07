def create_submission_from_api!
  data =
    JSON.parse(
      File.read("spec/fixtures/new_registration.json")
    )["data"]["attributes"]

  Submission.create(data)
end

def visit_unassigned_submission
  submission = create(:unassigned_submission)
  login_to_part_3
  visit submission_path(submission)
end

def visit_assigned_submission
  submission = create(:assigned_submission)
  login_to_part_3(submission.claimant)
  visit submission_path(submission)
end

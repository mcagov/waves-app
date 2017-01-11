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

def claim_submission_and_visit
  login_to_part_3
  click_on("Unclaimed Tasks")
  click_on("Claim")
  click_on("Process Next Application")
end

def visit_assigned_part_2_submission
  submission = create(:assigned_submission, part: :part_2)
  login_to_part_2(submission.claimant)
  visit submission_path(submission)
end

def create_incomplete_submission!
  data =
    JSON.parse(
      File.read("spec/fixtures/new_registration.json")
    )["data"]["attributes"]
  Submission::NewRegistration.create(data)
end

def create_incomplete_paid_submission!
  submission = create_incomplete_submission!
  pay_submission(submission)

  submission.reload
end

def create_unassigned_submission!
  submission = create_incomplete_submission!
  pay_submission(submission)

  submission.declarations.incomplete.map(&:declared!)
  submission.reload
end

def create_unassigned_urgent_submission!
  submission = create_incomplete_submission!
  pay_submission(submission, "urgent_payment")

  submission.declarations.incomplete.map(&:declared!)
  submission.reload
end

def create_assigned_submission!
  submission = create_unassigned_submission!

  submission.claimed!(create(:user))
  submission.reload
end

def create_referred_submission!
  submission = create_assigned_submission!

  submission.referred!
  submission.reload
end

def create_printing_submission!
  submission = create_assigned_submission!
  submission.approved!(1.day.ago)

  submission.reload
end

def create_completed_submission!
  submission = create_printing_submission!
  submission.printed!

  submission.reload
end

def visit_assigned_submission
  submission = create_assigned_submission!

  # we don't need the second declaration
  submission.declarations.last.destroy

  login_to_part_3(submission.claimant)
  visit submission_path(submission)
end

def visit_completed_submission
  submission = create_completed_submission!

  # we don't need the second declaration
  submission.declarations.last.destroy

  login_to_part_3(submission.claimant)
  visit submission_path(submission)
end

def pay_submission(submission, payment_file = "new_payment")
  payment_json =
    JSON.parse(File.read("spec/fixtures/#{payment_file}.json"))

  payment = Payment.new(payment_json["data"]["attributes"])
  payment.update_attribute(:submission_id, submission.id)
  submission.paid!
  submission
end

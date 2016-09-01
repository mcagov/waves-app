module SubmissionHelpers
  def new_registration_attributes
    JSON.parse(File.read('spec/fixtures/new_registration.json'))["data"]["attributes"]
  end

  def create_incomplete_submission!
    NewRegistration.create(new_registration_attributes)
  end

  def create_declared_submission!
    submission = create_incomplete_submission!
    submission.declarations.incomplete.map(&:declare!)
    submission
  end

  def create_paid_submission!
    submission = create_declared_submission!

    new_payment_json = JSON.parse(File.read("spec/fixtures/new_payment.json"))
    payment = Payment.new(new_payment_json["data"]["attributes"])
    payment.update_attribute(:submission_id, submission.id)

    submission.paid!
    submission
  end

  def create_urgent_paid_submission!
    submission = create_declared_submission!

    new_payment_json =
      JSON.parse(File.read("spec/fixtures/urgent_payment.json"))
    payment = Payment.new(new_payment_json["data"]["attributes"])
    payment.update_attribute(:submission_id, submission.id)

    submission.paid!
    submission
  end

  def create_completeable_submission!
    submission = create_paid_submission!

    submission.update_attribute(:claimant, create(:user))

    submission.claimed!
    submission
  end

  def visit_completeable_submission
    submission = create_completeable_submission!
    login_to_part_3(submission.claimant)
    visit submission_path(submission)
  end

  def visit_claimed_submission
    submission = create_completeable_submission!
    login_to_part_3(submission.claimant)
    visit submission_path(submission)
  end
end

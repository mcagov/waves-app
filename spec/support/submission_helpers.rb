module SubmissionHelpers
  def create_submission!
    # long - but easy to cut and paste!
    NewRegistration.create(JSON.parse(File.read('spec/fixtures/new_registration.json'))["data"]["attributes"])
  end

  def create_paid_submission!
    submission = create_submission!

    new_payment_json = JSON.parse(File.read('spec/fixtures/new_payment.json'))
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
end
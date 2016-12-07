FactoryGirl.define do
  factory :submission do
    part "part_3"
    task :new_registration
    applicant_name Faker::Name.name
    applicant_email Faker::Internet.safe_email
    changeset do
      {
        owners: [build(:declaration_owner)],
        vessel_info: build(:submission_vessel),
        delivery_address: build(:submission_delivery_address),
        agent: build(:submission_agent),
      }
    end
  end

  factory :incomplete_submission, parent: :submission do
    after(:create) do |submission|
      submission.build_defaults
    end
  end

  factory :unassigned_submission, parent: :incomplete_submission do
    after(:create) do |submission|
      submission.declarations.map(&:declared!)
      create(:payment, submission: submission)
    end
  end

  factory :unassigned_change_vessel_submission, class: "Submission" do
    task          :change_vessel
    source        :manual_entry
    vessel_reg_no { create(:registered_vessel).reg_no }

    after(:create) do |submission|
      submission.build_defaults
    end
  end

  factory :assigned_submission, parent: :unassigned_submission do
    after(:create) do |submission|
      submission.claimed!(create(:user))
    end
  end

  factory :cancelled_submission, parent: :assigned_submission do
    after(:create) do |submission|
      submission.cancelled!
    end
  end

  factory :assigned_closure_submission, parent: :assigned_submission do
    task          :closure
    vessel_reg_no { create(:registered_vessel).reg_no }
  end

  factory :referred_submission, parent: :assigned_submission do
    after(:create) do |submission|
      submission.update_attribute(:referred_until, 30.days.from_now)
      submission.referred!
    end
  end

  factory :expired_referred_submission, parent: :assigned_submission do
    after(:create) do |submission|
      submission.update_attribute(:referred_until, 1.day.ago)
      submission.referred!
    end
  end

  factory :completed_submission, parent: :assigned_submission do
    after(:create) do |submission|
      submission.approved!({})
    end
  end

  factory :paid_submission, parent: :unassigned_submission do
  end

  factory :paid_urgent_submission, parent: :submission do
    after(:create) do |submission|
      create(:payment, submission: submission, amount: 7500)
    end
  end

  factory :part_paid_submission, parent: :submission do
    after(:create) do |submission|
      create(:payment, submission: submission, amount: 10)
    end
  end
end

FactoryGirl.define do
  factory :submission do
    part "part_3"
    task :new_registration
    changeset do
      {
        owners: [build(:declaration_owner)],
        vessel_info: build(:submission_vessel),
      }
    end
  end

  factory :unassigned_change_vessel_submission, class: "Submission" do
    task          :change_vessel
    source        :manual_entry
    vessel_reg_no { create(:registered_vessel).reg_no }

    after(:create) do |submission|
      submission.build_defaults
      submission.touch
    end
  end

  factory :paid_submission, parent: :submission do
    after(:create) do |submission|
      create(:payment, submission: submission)
    end
  end

  factory :assigned_submission, parent: :paid_submission do
    after(:create) do |submission|
      submission.claimed!(create(:user))
    end
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
      submission.completed!
    end
  end
end

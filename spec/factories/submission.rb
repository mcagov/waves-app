FactoryGirl.define do
  factory :submission do
    part "part_3"
    changeset { { owners: [build(:declaration_owner)] } }
  end

  factory :paid_submission, parent: :submission do
    payment { build(:payment) }
  end

  factory :assigned_submission, parent: :paid_submission do
    after(:create) do |submission|
      submission.claimed!
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
end

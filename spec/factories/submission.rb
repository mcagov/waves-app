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

  factory :electronic_delivery_submission, parent: :submission do
    task :current_transcript
    vessel_reg_no { create(:registered_vessel).reg_no }
    changeset { { electronic_delivery: true } }
  end

  factory :unassigned_submission, parent: :incomplete_submission do
    after(:create) do |submission|
      submission.declarations.map do |declaration|
        declaration.declared! if declaration.can_transition?(:declared)
      end

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

  factory :approvable_submission, parent: :unassigned_submission do
    after(:create) do |submission|
      submission.claimed!(create(:user))
      submission.declarations.first.update_attribute(:shares_held, 64)
      submission.update_attribute(
        :correspondent_id, submission.declarations.first.id)
    end
  end

  factory :cancelled_submission, parent: :assigned_submission do
    after(:create) do |submission|
      submission.cancelled!
    end
  end

  factory :assigned_re_registration_submission, parent: :assigned_submission do
    task          :re_registration
    vessel_reg_no { create(:registered_vessel).reg_no }
  end

  factory :assigned_change_address_submission, parent: :assigned_submission do
    task          :change_address
    vessel_reg_no { create(:registered_vessel).reg_no }
  end

  factory :assigned_change_vessel_submission, parent: :assigned_submission do
    task          :change_vessel
    vessel_reg_no { create(:registered_vessel).reg_no }
  end

  factory :assigned_closure_submission, parent: :assigned_submission do
    task          :closure
    vessel_reg_no { create(:registered_vessel).reg_no }
    changeset do
      {
        owners: [build(:declaration_owner)],
        vessel_info: build(:submission_vessel),
        closure: build(:closure_destroyed),
      }
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
      submission.approved!({})
    end
  end

  factory :paid_submission, parent: :unassigned_submission do
  end

  factory :paid_premium_submission, parent: :submission do
    after(:create) do |submission|
      create(:payment, submission: submission, amount: 5000)
    end
  end

  factory :part_paid_submission, parent: :submission do
    after(:create) do |submission|
      create(:payment, submission: submission, amount: 10)
    end
  end

  factory :fishing_submission, parent: :assigned_submission do
    task :change_vessel
    part :part_2
    vessel_reg_no { create(:fishing_vessel).reg_no }
  end

  factory :part_4_fishing_submission, parent: :assigned_submission do
    task :change_vessel
    part :part_4
    vessel_reg_no { create(:registered_vessel, part: :part_4).reg_no }
    after(:create) do |submission|
      vessel = submission.vessel
      vessel.registration_type = :fishing
      submission.vessel = vessel
      submission.save
    end
  end

  factory :pleasure_submission, parent: :assigned_submission do
    task :change_vessel
    part :part_1
    vessel_reg_no { create(:pleasure_vessel).reg_no }
  end
end

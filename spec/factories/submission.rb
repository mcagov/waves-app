FactoryBot.define do
  factory :submission do
    part :part_3
    application_type :new_registration
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
    after(:create) do |submission|
      submission.build_defaults
    end

    trait :part_1_vessel do
      part :part_1
      vessel_reg_no { create(:registered_vessel, part: :part_1).reg_no }
    end

    trait :part_2_vessel do
      part :part_2
      vessel_reg_no { create(:registered_vessel, part: :part_2).reg_no }
    end

    trait :part_3_vessel do
      vessel_reg_no { create(:registered_vessel, part: :part_3).reg_no }
    end

    trait :closed_part_3_vessel do
      vessel_reg_no { create(:closed_vessel, part: :part_3).reg_no }
    end

    trait :part_4_fishing_vessel do
      part :part_4
      vessel_reg_no { create(:part_4_fishing_vessel).reg_no }
      after(:create) do |submission|
        submission.changeset[:vessel_info][:registration_type] = :fishing
        submission.save
      end
    end

    trait :part_4_vessel do
      part :part_4
      vessel_reg_no { create(:part_4_vessel).reg_no }
    end

    trait :high_profile do
      after(:create) do |submission|
        submission.changeset[:vessel_info][:registration_type] = :high_profile
        submission.save
      end
    end

    trait :commercial do
      after(:create) do |submission|
        submission.changeset[:vessel_info][:registration_type] = :commercial
        submission.save
      end
    end

    factory :high_profile_part_1_submission,
            traits: [:high_profile, :part_1_vessel]

    factory :commercial_part_1_submission,
            traits: [:commercial, :part_1_vessel]
  end

  factory :closed_submission, parent: :submission do
    after(:create) do |submission|
      submission.close!
    end
  end
end

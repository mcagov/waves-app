FactoryGirl.define do
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
  end

  factory :completed_submission, parent: :submission do
    after(:create) do |submission|
      submission.complete!
    end
  end

  factory :submission_for_part_1_vessel, parent: :submission do
    part :part_1
    vessel_reg_no { create(:registered_vessel, part: :part_1).reg_no }
  end

  factory :submission_for_part_2_vessel, parent: :submission do
    part :part_2
    vessel_reg_no { create(:registered_vessel, part: :part_2).reg_no }
  end

  factory :submission_for_part_3_vessel, parent: :submission do
    part :part_3
    vessel_reg_no { create(:registered_vessel, part: :part_3).reg_no }
  end
end

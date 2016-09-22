FactoryGirl.define do
  factory :new_registration, class: "Submission::NewRegistration" do
    part "part_3"
    changeset do
      {
        owners: [build(:declaration_owner)],
        vessel_info: build(:vessel),
      }
    end
  end
end

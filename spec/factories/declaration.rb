FactoryGirl.define do
  factory :declaration do
    changeset { build(:declaration_owner) }
    submission { build(:submission) }
  end
end

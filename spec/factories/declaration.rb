FactoryGirl.define do
  factory :declaration do
    owner { build(:declaration_owner) }
    submission { build(:submission) }
  end
end

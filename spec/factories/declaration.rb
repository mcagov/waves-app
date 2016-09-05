FactoryGirl.define do
  factory :declaration do
    changeset { build(:declaration_owner) }
  end
end

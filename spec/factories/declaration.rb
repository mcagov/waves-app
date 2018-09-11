FactoryBot.define do
  factory :declaration do
    owner { build(:declaration_owner) }
    submission { create(:submission) }
  end
end

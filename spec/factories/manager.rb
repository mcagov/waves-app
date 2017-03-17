FactoryGirl.define do
  factory :manager do
    safety_management { build(:safety_management) }
  end
end

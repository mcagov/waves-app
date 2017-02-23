FactoryGirl.define do
  factory :mortgage do
    mortgage_type "Intent"
    mortgagees    { [build(:mortgagee)] }
  end
end

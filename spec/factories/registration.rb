FactoryGirl.define do
  factory :registration do
    vessel              { build(:vessel) }
    delivery_address    { build(:address) }
    status              "initial"
  end
end

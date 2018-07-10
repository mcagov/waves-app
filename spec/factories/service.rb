FactoryGirl.define do
  factory :service do
  end

  factory :demo_service, parent: :service do
    name "Demo Service"
    standard_days 10
    premium_days 1
    part_1 { { standard: 124, premium: 180, subsequent: 99 } }
    part_3 { { standard: 25, premium: 50 } }
    part_4 { { standard: 124, premium: 180 } }
  end
end

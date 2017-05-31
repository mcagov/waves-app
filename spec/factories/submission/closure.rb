FactoryGirl.define do
  factory :closure, class: "Submission::Closure" do
    actioned_day         "23"
    actioned_month       "6"
    actioned_year        "2016"
  end

  factory :closure_destroyed, parent: :closure do
    reason               :destroyed
    destruction_method   "BOMB"
  end

  factory :closure_sold, parent: :closure do
    reason                  :sold
    new_owner_name          "BOB"
    new_owner_email         "bob@example"
    new_owner_phone_number  "12345"
  end

  factory :closure_registered_elsewhere, parent: :closure do
    reason                  :registered_elsewhere
    new_flag                "FRANCE"
    new_flag_reason         "MOVED HOUSE"
  end

  factory :closure_other, parent: :closure do
    reason               :other
    other_reason         "DONT WANT"
  end
end

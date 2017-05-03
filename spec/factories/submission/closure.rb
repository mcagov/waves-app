FactoryGirl.define do
  factory :closure, class: "Submission::Closure" do
    actioned_day         { "23" }
    actioned_month       { "6" }
    actioned_year        { "2016" }
  end

  factory :closure_destroyed, parent: :closure do
    reason               :destroyed
    destruction_method   { "BOMB" }
  end
end

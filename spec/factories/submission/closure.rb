FactoryGirl.define do
  factory :closure_destroyed, class: "Submission::Closure" do
    reason               :destroyed
    actioned_day         { "23" }
    actioned_month       { "6" }
    actioned_year        { "2016" }
    destruction_method   { "VIKING FUNERAL" }
  end
end

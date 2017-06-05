FactoryGirl.define do
  factory :line_item, class: "Submission::LineItem" do
    submission    { build(:submission) }
    fee           { build(:fee) }
    price         2500
  end
end

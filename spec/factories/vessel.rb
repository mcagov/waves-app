FactoryGirl.define do
  factory :vessel, class: "Register::Vessel" do
    name  Faker::Beer.name
  end
end

FactoryGirl.define do
  factory :vessel, class: "Register::Vessel" do
    name            Faker::Beer.name
    number_of_hulls 1
  end
end
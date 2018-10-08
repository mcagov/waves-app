FactoryBot.define do
  factory :submission_delivery_address, class: "Submission::DeliveryAddress" do
    name      "BOB DOLE"
    address_1 "11 DOWNING ST"
    address_2 "WHITEHALL"
    town      "CARDIFF"
    postcode  "W1 1AF"
    country   "UNITED KINGDOM"
  end
end

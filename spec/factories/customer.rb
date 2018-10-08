FactoryBot.define do
  factory :customer do
    name "Bob"
    email "bob@example.com"
    address_1 "10 DOWNING ST"
    address_2 "WHITEHALL"
    town      "LONDON"
    postcode  "W1 1AA"
    country   "UNITED KINDOM"
  end
end

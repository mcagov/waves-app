FactoryBot.define do
  factory :registered_representative, class: "Register::Representative" do
    name "Ronnie Rogue"
    address_1     "2 KEEN ROAD"
    town          "LONDON"
    country       "UNITED KINGDOM"
    postcode      "QZ2 3QM"
    nationality   "BRITISH"
  end
end

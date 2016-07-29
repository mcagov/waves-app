FactoryGirl.define do
  factory :owner do
    name  { ["Edward McCallister", "Horatio Nelson", "Jack Sparrow"].sample }
    nationality { Owner::ALLOWED_NATIONALITIES.sample }

    sequence(:email) do |n|
      "#{name.parameterize}.#{n}@example.com".downcase
    end

    phone_number { rand.to_s[2..12] }

    address { build(:address) }
  end
end

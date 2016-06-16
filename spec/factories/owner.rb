FactoryGirl.define do
  factory :owner do
    title       { %w(Miss Mr Mrs Ms).sample }
    first_name  { %w(Edward Horatio Jack Walter).sample }
    last_name   { %w(McCallister Nelson Raleigh Smith Sparrow).sample }
    nationality { Owner::ALLOWED_NATIONALITIES.sample }

    sequence(:email) do |n|
      "#{first_name}.#{last_name}.#{n}@example.com".downcase
    end

    mobile_number { "07#{rand.to_s[2..10]}" }

    address { build(:address) }
  end
end

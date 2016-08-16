FactoryGirl.define do
  factory :registration do
    changeset {{}}
  end

  factory :paid_registration, class: :registration do
    payment { build(:payment)}
    changeset {{}}
  end
end

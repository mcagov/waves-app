FactoryGirl.define do
  factory :registration do
    changeset {{}}
  end

  factory :paid_registration, class: :registration do
    payment { create(:payment)}
    changeset {{}}
  end
end

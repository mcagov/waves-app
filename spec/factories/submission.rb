FactoryGirl.define do
  factory :submission do
    changeset {{}}
  end

  factory :paid_submission, class: :submission do
    payment { build(:payment)}
    changeset {{}}
  end
end

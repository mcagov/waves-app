FactoryGirl.define do
  factory :submission do
    part "part_3"
    changeset {{}}
  end

  factory :paid_submission, class: :submission do
    payment { build(:payment)}
    part "part_3"
    changeset {{}}
  end
end

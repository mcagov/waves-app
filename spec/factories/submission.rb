FactoryGirl.define do
  factory :submission do
    part "part_3"
    changeset { { owners: [build(:declaration_owner)] } }
  end

  factory :paid_submission, class: :submission do
    payment { build(:payment) }
    part "part_3"
    changeset { { owners: [build(:declaration_owner)] } }
  end

  factory :referred_submission, class: :submission do
    payment { build(:payment) }
    part "part_3"
    changeset { { owners: [build(:declaration_owner)] } }
    state :referred
  end
end

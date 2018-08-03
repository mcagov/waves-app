FactoryBot.define do
  factory :carving_and_marking do
    submission      { build(:submission, part: :part_2) }
    actioned_by     { build(:user) }
    template        { CarvingAndMarking::TEMPLATES.sample[1] }
  end

  factory :emailable_carving_and_marking, parent: :carving_and_marking do
    delivery_method :email
  end

  factory :printable_carving_and_marking, parent: :carving_and_marking do
    delivery_method :print
  end
end

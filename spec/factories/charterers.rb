FactoryGirl.define do
  factory :charterer do
    charter_parties { [build(:charter_party)] }
  end

  factory :declared_charterer, parent: :charterer do
    charter_parties { [build(:charter_party, declaration_signed: true)] }
  end
end

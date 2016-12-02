FactoryGirl.define do
  factory :work_log do
    submission    { create(:submission) }
    actioned_by   { create(:user) }
    part          :part_3
    description   { [:document_entry, :processed_application].sample }
  end
end

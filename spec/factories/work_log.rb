FactoryGirl.define do
  factory :work_log do
    description [:document_entry, :processed_application].sample
  end
end

FactoryGirl.define do
  factory :fee do
    category            :part_3_new_registration
    task_variant        :new_registration
    price               2500
    premium_addon_price 5000
  end
end

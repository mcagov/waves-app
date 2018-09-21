FactoryBot.define do
  factory :staff_performance_log do
    activity 1
    actioned_by { build(:user) }
    task { create(:task) }
  end
end

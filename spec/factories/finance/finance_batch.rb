FactoryGirl.define do
  factory :finance_batch, class: "FinanceBatch" do
    starts_at    { Date.today }
    started_by   { build(:user) }
  end
end

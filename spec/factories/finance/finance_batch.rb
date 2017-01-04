FactoryGirl.define do
  factory :finance_batch, class: "FinanceBatch" do
    opened_at      { Date.today }
    processed_by   { build(:user) }
  end
end

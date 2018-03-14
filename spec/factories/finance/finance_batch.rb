FactoryGirl.define do
  factory :finance_batch, class: "FinanceBatch" do
    opened_at      { Date.today }
    processed_by   { build(:user) }
    after(:create) do |batch|
      create(:finance_payment, batch: batch)
    end
  end

  factory :empty_finance_batch, class: "FinanceBatch" do
    opened_at      { Date.today }
    processed_by   { build(:user) }
  end
end

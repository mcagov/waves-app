FactoryGirl.define do
  factory :finance_payment, class: "Payment::FinancePayment" do
    payment_date    { Date.today }
    part            :part_3
    task            :new_registration
    payment_amount  25.00
    batch           { build(:finance_batch) }
  end
end

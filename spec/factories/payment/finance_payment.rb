FactoryGirl.define do
  factory :finance_payment, class: "Payment::FinancePayment" do
    part            :part_3
    task            :new_registration
    payment_amount  25.00
  end
end

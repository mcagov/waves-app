FactoryBot.define do
  factory :print_job do
    printable { build(:submission) }
    part :part_3
    template :blank
  end
end

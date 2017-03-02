FactoryGirl.define do
  factory :submission_name_approval, class: "Submission::NameApproval" do
    part                :part_2
    sequence(:name)     { |n| "Name #{n}" }
    sequence(:port_no)  { |n| n }
    port_code           "AA"
    approved_until      { 90.days.from_now }
    submission          { create(:submission, part: :part_2) }
  end
end

FactoryBot.define do
  factory :work_log do
    task          { create(:task) }
    actioned_by   { create(:user) }
    part          :part_3
    description   { [:document_added, :task_completed].sample }
  end
end
